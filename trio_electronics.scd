
// June 8, 2018
// revised Nov 24, 2022
// Electronics for Trio- for Eb clarinet, Bass clarinet and electronics
/* This script is used to generate electronics sound files for the piece. The sound files will be triggered using QLab by the Eb clarinettist using ActitioN 4 button controller. Sound files 1_mono and 8_mono that are modified from the 1st and 8th sound file generated from this script, are part of the buffer reading for generating later sound files. The midiBlock in this script is taken from the study for violin and electronics, one of my previous pieces. Online sources on granular synth are implemented.
*/
/* Instruction:
1. Change buffer directory of pre-recorded 8_mono sound file (line 1368, 1434) and 1_mono sound file (line 1589, 2378) to the directory where both files are stored. 8_mono and 1_mono files are within the downloaded zip.
2. Booth SuperCollider. Move cursor to the end of line 17 and press command + enter.
3. Move cursor to the beginning of line 19, lines 19 to 153 will be automatically highlighted. Run these lines by pressing command + enter.
4. Run the subsequent code labeled by numbers, which correspond to the sound file number of electronics part. For example, to playback the sound of sound file number 1, move the cursor to the beginning of line 161, this will automatically highlight corresponding lines of code, and press command + enter to start processes.
If you wish to stop the sound before its end, press command + . (period).
Note, once you have ran lines 19 to 153, the running of the subsequent parts of the code do not have to be in sequence.
*/
// note: each sound effect is recorded using this line s.record(path: "Users/shuyulin/Music/SuperCollider Recordings/84.wav".standardizePath);

s.boot;

(
~midiBlock = [ [ [ 64, 60, 61, 66, 71, 60, 68 ], [ 68, 60, 71, 66, 61, 60, 64 ], [ 64, 68, 67, 62, 69, 68, 60 ], [ 60, 68, 69, 62, 67, 68, 64 ] ], [ [ 61, 69, 70, 63, 68, 69, 65 ], [ 65, 69, 68, 63, 70, 69, 61 ], [ 61, 65, 64, 71, 66, 65, 69 ], [ 69, 65, 66, 71, 64, 65, 61 ] ], [ [ 66, 62, 63, 68, 61, 62, 70 ], [ 70, 62, 61, 68, 63, 62, 66 ], [ 66, 70, 69, 64, 71, 70, 62 ], [ 62, 70, 71, 64, 69, 70, 66 ] ], [ [ 71, 67, 68, 61, 66, 67, 63 ], [ 63, 67, 66, 61, 68, 67, 71 ], [ 71, 63, 62, 69, 64, 63, 67 ], [ 67, 63, 64, 69, 62, 63, 71 ] ], [ [ 68, 64, 65, 70, 63, 64, 60 ], [ 60, 64, 63, 70, 65, 64, 68 ], [ 68, 60, 71, 66, 61, 60, 64 ], [ 64, 60, 61, 66, 71, 60, 68 ] ] ];

// remove repeated notes (two same notes in the row)
~oldNote = 40;
~filterNote = {
~newNote = (~midiBlock[rrand(0, 4)][rrand(0, 3)][rrand(0, 6)]);
if(~newNote == ~oldNote, {
~newNote = (~midiBlock[rrand(0, 4)][rrand(0, 3)][rrand(0, 6)]);
});
~oldNote = ~newNote;
~newNote;
};


SynthDef("playRandNotesSine", {
	arg freq, env, amp = 0.8, out = 0, pan = 1; // pan = -1 = start from left
	var sig, outArray, bus;
	sig = SinOsc.ar(freq, 0, amp);
	env = EnvGen.kr(Env.new([0, 1, 0.3, 0], [0.0001, 0.1, 1.8],[-5, 0, -3]), doneAction: 2);
	outArray = sig * env * amp; // only 1 signal in the array
	outArray = Pan2.ar(outArray,pan); // add this line for panning
	Out.ar(out, outArray); // output to left channel
}).add; // add to server to be played later

SynthDef("playRandNotesSine2", {
	arg freq, env, amp = 0.8, out = 0, pan = 1; // pan = -1 = start from left
	var sig, outArray, bus;
	sig = SinOsc.ar(freq, 0, amp);
	env = EnvGen.kr(Env.new([0, 1, 0.3, 0], [0.0001, 0.01, 0.0099],[-5, 0, -3]), doneAction: 2);
	outArray = sig * env * amp; // only 1 signal in the array
	outArray = Pan2.ar(outArray,pan); // add this line for panning
	Out.ar(out, outArray); // output to left channel
}).add; // add to server to be played later

SynthDef("playRandNotesSine3", {
	arg freq, env, amp = 0.8, out = 0, pan = 1; // pan = -1 = start from left
	var sig, outArray, bus;
	sig = RLPF.ar(SinOsc.ar(freq, 0, amp), freq, 1);
	env = EnvGen.kr(Env.new([0, 1, 0.5, 0], [0.06, 0.1, 1.8],[-5, 0.3, -5]), doneAction: 2);
	outArray = sig * env * amp; // only 1 signal in the array
	outArray = Pan2.ar(outArray,pan); // add this line for panning
	Out.ar(out, outArray); // output to left channel
}).add; // add to server to be played later

SynthDef("playRandNotesSineCut", {
	arg freq, env, amp = 0.8, out = 0, pan = 1; // pan = -1 = start from left
	var sig, outArray, bus;
	sig = SinOsc.ar(freq, 0, amp);
	env = EnvGen.kr(Env.new([0, 1, 0.3, 0], [2, 0.01, 0.0099],[5, 0, -3]), doneAction: 2);
	outArray = sig * env * amp; // only 1 signal in the array
	outArray = Pan2.ar(outArray,pan); // add this line for panning
	Out.ar(out, outArray); // output to left channel
}).add; // add to server to be played later

SynthDef("playRandNotesSineCut2", {
	arg freq, env, amp = 0.8, out = 0, pan = 1; // pan = -1 = start from left
	var sig, outArray, bus;
	sig = SinOsc.ar(freq, 0, amp);
	env = EnvGen.kr(Env.new([0, 0.2, 1, 0], [0.0099, 0.01, 2],[3, 0, -5]), doneAction: 2);
	outArray = sig * env * amp; // only 1 signal in the array
	outArray = Pan2.ar(outArray,pan); // add this line for panning
	Out.ar(out, outArray); // output to left channel
}).add; // add to server to be played later

SynthDef("playRandNotesSineLong", {
	arg freq, env, amp = 0.8, out = 0, pan = 1; // pan = -1 = start from left
	var sig, outArray, bus;
	sig = SinOsc.ar(freq, 0, amp);
	env = EnvGen.kr(Env.new([0, 0.9, 0], [3, 1],[5, -5]), doneAction: 2);
	outArray = sig * env * amp; // only 1 signal in the array
	outArray = Pan2.ar(outArray,pan); // add this line for panning
	Out.ar(out, outArray); // output to left channel
}).add; // add to server to be played later

SynthDef("playRandNotesSineForDing", {
	arg freq, env, amp = 0.8, out = 0, pan = 1; // pan = -1 = start from left
	var sig, outArray, bus;
	sig = SinOsc.ar(freq, 0, amp);
	env = EnvGen.kr(Env.new([0, 1, 0.3, 0], [0.05, 0.3, 0.15],[-5, 0, 0]), doneAction: 2);
	outArray = sig * env * amp; // only 1 signal in the array
	outArray = Pan2.ar(outArray,pan); // add this line for panning
	Out.ar(out, outArray); // output to left channel
}).add;

SynthDef("playRandNotesSaw", {
	arg freq, env, amp = 0.8, out=0, pan= 1;
	var sig, outArray, bus;
	sig = RLPF.ar(Resonz.ar(BPF.ar(Saw.ar(freq, amp), freq, 1), freq, 1), freq, 1);
	env = EnvGen.kr(Env.new([0, 1, 0.3, 0], [0.0001, 0.1, 1.8],[-5, 0, -3]), doneAction: 2);
	outArray = sig * env * amp;
	outArray = Pan2.ar(outArray, pan);
	Out.ar(out, outArray);
}).add;

SynthDef("playRandNotesSaw2", {
	arg freq, env, amp = 0.8, out=0, pan= 1;
	var sig, outArray, bus;
	sig = RLPF.ar(BPF.ar(Saw.ar(freq, amp), freq, 1), freq, 1);
	env = EnvGen.kr(Env.new([0, 1, 0.3, 0], [0.1, 0.6, 1.8],[-5, -2, -3]), doneAction: 2);
	outArray = sig * env * amp;
	outArray = Pan2.ar(outArray, pan);
	Out.ar(out, outArray);
}).add;

SynthDef("playRandNotesSaw3", {
	arg freq, env, amp = 0.8, out=0, pan= 1;
	var sig, outArray, bus;
	sig = RLPF.ar(BPF.ar(Saw.ar(freq, amp), freq, 1), freq, 1);
	env = EnvGen.kr(Env.new([0, 0.9, 0], [0.4, 1.8],[-5, -3]), doneAction: 2);
	outArray = sig * env * amp;
	outArray = Pan2.ar(outArray, pan);
	Out.ar(out, outArray);
}).add;

SynthDef("playRandNotesSaw4", {
	arg freq, env, amp = 0.8, out=0, pan= 1;
	var sig, outArray, bus;
	sig = RLPF.ar(Resonz.ar(Saw.ar(freq, amp), freq, 1), freq, 1);
	env = EnvGen.kr(Env.new([0, 1, 0.5, 0], [0.06, 0.1, 1.8],[-5, 0.3, -5]), doneAction: 2);
	outArray = sig * env * amp;
	outArray = Pan2.ar(outArray, pan);
	Out.ar(out, outArray);
}).add;

SynthDef("playRandNotesSawPan", {
	arg freq, env, amp = 0.8, out=0, pan= -1;
	var sig, outArray, bus;
	sig = RLPF.ar(Resonz.ar(BPF.ar(Saw.ar(freq, amp), freq, 1), freq, 1), freq, 1);
	env = EnvGen.kr(Env.new([0, 1, 0.3, 0], [0.0001, 0.1, 1.8],[-5, 0, -3]), doneAction: 2);
	outArray = sig * env * amp;
	outArray = Pan2.ar(outArray, pan);
	Out.ar(out, outArray);
}).add;
)




//// 1
// cloud rand register
// 14" with fade out and rit
({
	var tempo = 1;
	~transposeArrIn1 = Array.fill(750, {rrand(-108, 108)});
	~ampArrIn1 = Array.fill(750, {rrand(0.0005, 0.5)});

	Ndef(\1).fadeTime = 0.01; // fade in duration; cross this out will have about 1 second of fade in
	Ndef(\1, Pdef(\pat1) ); // assign \26 to \pattPlay
	TempoClock.tempo = tempo; // set the current system tempo

	~patIn1 = Pbind(\instrument, Prand(["playRandNotesSine"], 750), \midinote, Pfunc({
	(~filterNote.() ).postln;
}), \dur, 0.02, \amp, Pseq(~ampArrIn1, 1), \ctranspose, Pseq(~transposeArrIn1, 1), \pan, 0);

	Pdef(\pat1, ~patIn1);
	Ndef(\1).play;

	10.yield; //wait for 5 seconds for the above to finish playing and then run the rest of the code to fade out
	"fadeout".postln;

Ndef(\1).fadeTime = 6; // duration of second part of this stream, refer to the fade out part
Ndef(\1, {}); // run \pattPlay again for this fade out part

	10.do { // 10 times of -0.1 to slow down; count down from 1 second and then -0.1 each repetition
		TempoClock.tempo = tempo.postln; // set a new system tempo by using .tempo; default is beat per second
		tempo = tempo - 0.1; // increase duration between notes to rit (-0.1); decrease duration between notes to accel (+0.1 or more)
		0.1.yield; // give each beat 0.1 second
	}

}.fork; // entire thing as a stream
)

//// record sound file; run this line for each sound effect in order to record
s.record(path: "Users/shuyulin/Music/SuperCollider Recordings/84.wav".standardizePath);





//// 2
// mid register cloud
// fade in 4 sec
// fade out 4 sec
// tempo don't change
(
	~transposeArrIn2 = Array.fill(200, {rrand(12, 24)});

// calculate amplitude
	~ampArr = Array.fill(200, {rrand(0.0005, 0.5)}).round(0.0001);
	~cresArr = Array.series(200, 0, 0.005).round(0.0001);
	~decresArr = ~cresArr.reverse;

// use these ones
	~ampArrCres = (~ampArr * ~cresArr).round(0.000001);
	~ampArrDecres = ~ampArrCres.reverse;

	~patIn2Cres = Pbind(\instrument, Prand(["playRandNotesSine"], 200), \midinote, Pfunc({
	(~filterNote.() ).postln;
}), \dur, 0.02, \amp, Pseq(~ampArrCres, 1), \ctranspose, Pseq(~transposeArrIn2, 1), \pan, 0);

	~patIn2Decres = Pbind(\instrument, Prand(["playRandNotesSine"], 200), \midinote, Pfunc({
	(~filterNote.() ).postln;
}), \dur, 0.02, \amp, Pseq(~ampArrDecres, 1), \ctranspose, Pseq(~transposeArrIn2, 1), \pan, 0);

	Pdef(\cres2).play;
	Pdef(\decres2).play;
)

(
~routineIn2 = Routine {
	Pdef(\cres2, ~patIn2Cres);
	4.yield;
	Pdef(\decres2, ~patIn2Decres);
}
)

~routineIn2.play;




//// 3
// low register cloud < mf in 4 seconds
// after cresc, continue for 8 seconds with fade out
// don't change tempo

(
// transposition for cres, sustain and decres
	~transposeArrIn3_cres = Array.fill(200, {rrand(-12, 1)});
	~transposeArrIn3_sustain = Array.fill(100, {rrand(-12, 1)});
	~transposeArrIn3_decres = Array.fill(250, {rrand(-12, 1)});

// calculate amplitude
	// crescendo
	~ampArrIn3_cres = Array.fill(200, {rrand(0.08, 0.9)}).round(0.0001);
	~cresArrIn3 = Array.series(200, 0, 0.0015).round(0.00001);
	~ampArrCresIn3 = (~ampArrIn3_cres * ~cresArrIn3).round(0.00001); // 4" crescendo

	// sustain
	~ampArrIn3_sustain = Array.fill(100, {rrand(0.05, 0.3)}).round(0.0001); // 2" sustain

	// decrescendo
	~ampArrIn3_decres = Array.fill(250, {rrand(0.05, 0.9)}).round(0.0001);
	~decresArrIn3 = (Array.series(250, 0, 0.0012).round(0.00001)).reverse;
	~ampArrDecresIn3 = (~ampArrIn3_decres * ~decresArrIn3).round(0.00001); // 5" decrescendo

	~patIn3Cres = Pbind(\instrument, Prand(["playRandNotesSine"], 200), \midinote, Pfunc({
	(~filterNote.() ).postln;
}), \dur, 0.02, \amp, Pseq(~ampArrCresIn3, 1), \ctranspose, Pseq(~transposeArrIn3_cres, 1), \pan, 0);

	~patIn3Sustain = Pbind(\instrument, Prand(["playRandNotesSine"], 100), \midinote, Pfunc({
	(~filterNote.() ).postln;
}), \dur, 0.02, \amp, Pseq(~ampArrIn3_sustain, 1), \ctranspose, Pseq(~transposeArrIn3_sustain, 1), \pan, 0);

	~patIn3Decres = Pbind(\instrument, Prand(["playRandNotesSine"], 250), \midinote, Pfunc({
	(~filterNote.() ).postln;
}), \dur, 0.02, \amp, Pseq(~ampArrDecresIn3, 1), \ctranspose, Pseq(~transposeArrIn3_decres, 1), \pan, 0);

	Pdef(\cresIn3).play;
	Pdef(\sustainIn3).play;
	Pdef(\decresIn3).play;
)

(
~routineIn3 = Routine {
	Pdef(\cresIn3, ~patIn3Cres).play;
	4.yield;
	Pdef(\sustainIn3, ~patIn3Sustain).play;
	2.yield;
	Pdef(\decresIn3, ~patIn3Decres).play;
}
)

~routineIn3.play;





//// 4
// 'ding' note
(
~noteIn4 = Pbind(\instrument, Prand(["playRandNotesSine"], 1), \midinote, Pfunc({
	(~filterNote.() ).postln;
}), \dur, 0.02, \amp, 0.8, \pan, 0);
~noteIn4.play;
)





//// 5
// mid register, 4 fast short notes; alternate with Eb clarinet
(
~notesIn5= Pbind(\instrument, Prand(["playRandNotesSaw"], 4), \midinote, Pfunc({
	(~filterNote.() ).postln;
}), \dur, 0.1, \amp, 0.8, \ctranspose, 1);

~notesIn5.play;
)





//// 6
// mid high register, 12 fast short notes; alternate with Eb clarinet
(
~notesIn6= Pbind(\instrument, Prand(["playRandNotesSine"], 12), \midinote, Pfunc({
	(~filterNote.() ).postln;
}), \dur, 0.083, \amp, 0.6, \ctranspose, 12);

~notesIn6.play;
)





//// 7
// high and low short run notes; both register together and then alternate; 4"
// high low together, high, low, mid registers
// 5.38"

(
~notesIn7_high1 = Pbind(\instrument, Prand(["playRandNotesSine"], 12), \midinote, Pfunc({
	(~filterNote.() ).postln;
}), \dur, 0.083, \amp, 0.6, \ctranspose, 24);

~notesIn7_low1= Pbind(\instrument, Prand(["playRandNotesSaw"], 20), \midinote, Pfunc({
	(~filterNote.() ).postln;
}), \dur, 0.03, \amp, 0.9, \ctranspose, -12);

~notesIn7_high2 = Pbind(\instrument, Prand(["playRandNotesSaw"], 12), \midinote, Pfunc({
	(~filterNote.() ).postln;
}), \dur, 0.06, \amp, 0.6, \ctranspose, 18);

~notesIn7_low2= Pbind(\instrument, Prand(["playRandNotesSaw"], 20), \midinote, Pfunc({
	(~filterNote.() ).postln;
}), \dur, 0.06, \amp, 0.9, \ctranspose, -10);

~notesIn7_mid = Pbind(\instrument, Prand(["playRandNotesSaw"], 28), \midinote, Pfunc({
	(~filterNote.() ).postln;
}), \dur, 0.06, \amp, 0.9, \ctranspose, 1);
)

(
r = Routine {
	~notesIn7_high1.play;
	~notesIn7_low1.play;
	1.5.yield;
	~notesIn7_high2.play;
	1.yield;
	~notesIn7_low2.play;
	1.2.yield;
	~notesIn7_mid.play;
}.play;
)





//// 8
(
~notesIn8_high = Pbind(\instrument, Prand(["playRandNotesSine"], 12), \midinote, Pfunc({
	(~filterNote.() ).postln;
}), \dur, 0.03, \amp, 0.6, \ctranspose, 24);

~notesIn8_low1= Pbind(\instrument, Prand(["playRandNotesSaw"], 20), \midinote, Pfunc({
	(~filterNote.() ).postln;
}), \dur, 0.083, \amp, 0.9, \ctranspose, -12);

~notesIn8_mid1 = Pbind(\instrument, Prand(["playRandNotesSaw"], 20), \midinote, Pfunc({
	(~filterNote.() ).postln;
}), \dur, 0.03, \amp, 0.7, \ctranspose, 1);

~notesIn8_mid2= Pbind(\instrument, Prand(["playRandNotesSaw"], 12), \midinote, Pfunc({
	(~filterNote.() ).postln;
}), \dur, 0.082, \amp, 0.5, \ctranspose, 1);

~notesIn8_low2 = Pbind(\instrument, Prand(["playRandNotesSaw"], 16), \midinote, Pfunc({
	(~filterNote.() ).postln;
}), \dur, 0.06, \amp, 0.9, \ctranspose, -12);
)

(
r = Routine {
	~notesIn8_high.play;
	~notesIn8_low1.play;
	1.yield;
	~notesIn8_mid1.play;
	1.yield;
	~notesIn8_mid2.play;
	1.yield;
	~notesIn8_low2.play;
}.play;
)





//// 9
// high and low sporadic (one with sine ins 2) together for 0.5 second
// then low (sine ins 2) for 0.5 sec
(
~notesIn9_high = Pbind(\instrument, Prand(["playRandNotesSine"], 16), \midinote, Pfunc({
	(~filterNote.() ).postln;
}), \dur, 0.03, \amp, 0.6, \ctranspose, 24);

~notesIn9_low1= Pbind(\instrument, Prand(["playRandNotesSine2"], 3), \midinote, Pfunc({
	(~filterNote.() ).postln;
}), \dur, 0.08, \amp, 0.8, \ctranspose, 1);

~notesIn9_low2 = Pbind(\instrument, Prand(["playRandNotesSine2"], 10), \midinote, Pfunc({
	(~filterNote.() ).postln;
}), \dur, 0.04, \amp, 0.7, \ctranspose, 1);
)

(
r = Routine {
	~notesIn9_high.play;
	~notesIn9_low1.play;
	1.yield;
	~notesIn9_low2.play;
}.play;
)





//// 10
// high continuous runs fade in on 3rd beat, continue for 3 seconds to the next bar
(
	~ampDecresArrIn10 = (Array.series(37, 0, 0.012).round(0.00001)).reverse;
	~patIn10Decres = Pbind(\instrument, Prand(["playRandNotesSaw"], 37), \midinote, Pfunc({
	(~filterNote.() ).postln;
}), \dur, 0.082, \amp, Pseq(~ampDecresArrIn10, 1), \ctranspose, 48, \pan, 0);

	Pdef(\decresIn10).play;
)

Pdef(\decresIn10, ~patIn10Decres).play;






//// 11; on the 4.5 beat low reg run (sharper)
(
~notesIn11 = Pbind(\instrument, Prand(["playRandNotesSine"], 1), \midinote, Pfunc({
	(~filterNote.() ).postln;
}), \dur, 0.125, \amp, 0.7, \ctranspose, -10);

~notesIn11_nonPitch = Pbind(\instrument, Prand(["playRandNotesSine2"], 1), \midinote, Pfunc({
	(~filterNote.() ).postln;
}), \dur, 0.125, \amp, 0.7, \ctranspose, -5);
)

(
r = Routine {
	~notesIn11.play;
	0.125.yield;
	~notesIn11_nonPitch.play;
	0.125.yield;
	~notesIn11.play;
	0.125.yield;
	~notesIn11.play;
}.play;
)





//// 12
// low, short, fast
(
~notesIn12 = Pbind(\instrument, Prand(["playRandNotesSaw2"], 5), \midinote, Pfunc({
	(~filterNote.() ).postln;
}), \dur, 0.1, \amp, 0.7, \ctranspose, -5);

~notesIn12.play;
)





//// 13
// mid, short, fast
(
~notesIn13 = Pbind(\instrument, Prand(["playRandNotesSaw2"], 6), \midinote, Pfunc({
	(~filterNote.() ).postln;
}), \dur, 0.083, \amp, 0.8, \ctranspose, 5);

~notesIn13.play;
)





//// 14
// long note, mid register; 6"; fade in 1", fade out 2"
(
~noteIn14 = Pbind(\instrument, Prand(["playRandNotesSineCut"], 1), \midinote, Pfunc({
	(~filterNote.() ).postln;
}), \dur, 0.02, \amp, 0.8, \pan, 0);
~noteIn14.play;
)





//// 15
(
~notesIn15 = Pbind(\instrument, Prand(["playRandNotesSaw2"], 4), \midinote, Pfunc({
	(~filterNote.() ).postln;
}), \dur, 0.08, \amp, 0.8, \ctranspose, -5);

~notesIn15.play;
)





//// 16
(
// calculate amplitude
	// crescendo
	~cresArrIn16 = Array.series(30, 0, 0.026).round(0.00001);

	// decrescendo
	~decresArrIn16 = (Array.series(20, 0, 0.04).round(0.00001)).reverse;

	~patIn16Cres = Pbind(\instrument, Prand(["playRandNotesSaw2"], 30), \midinote, Pfunc({
	(~filterNote.() ).postln;
}), \dur, 0.1, \amp, Pseq(~cresArrIn16, 1), \ctranspose, 12, \pan, 0);

	~patIn16Decres = Pbind(\instrument, Prand(["playRandNotesSaw2"], 20), \midinote, Pfunc({
	(~filterNote.() ).postln;
}), \dur, 0.1, \amp, Pseq(~decresArrIn16, 1), \ctranspose, 12, \pan, 0);

	Pdef(\cresIn16).play;
	Pdef(\decresIn16).play;
)

(
~routineIn16 = Routine {
	Pdef(\cresIn16, ~patIn16Cres).play;
	3.yield;
	Pdef(\decresIn16, ~patIn16Decres).play;
}
)

~routineIn16.play;





//// 17
(
~patIn17 = Pbind(\instrument, Prand(["playRandNotesSaw"], 63), \midinote, Pfunc({
	(~filterNote.() ).postln;
}), \dur, 0.04, \amp, 0.6, \ctranspose, 12, \pan, 0);
)

~patIn17.play;






//// 18
(
~noteIn18 = Pbind(\instrument, Prand(["playRandNotesSineForDing"], 1), \midinote, Pfunc({
	(~filterNote.() ).postln;
}), \dur, 0.02, \amp, 0.8, \ctranspose, 12, \pan, 0);
~noteIn18.play;
)





//// 19
(
~clusterIn19_mid = Pbind(\instrument, Prand(["playRandNotesSine"], 1), \midinote, Pfunc({
	(~filterNote.() ).postln;
}), \dur, 0.02, \amp, 0.45, \ctranspose, 1, \pan, 0);
)

(
10.do {
	~clusterIn19_mid.play;
}
)





//// 20
// mid register sporadic runs
(
~decresIn20 = (Array.series(100, 0, 0.006).round(0.00001)).reverse;

~patIn20_1 = Pbind(\instrument, Prand(["playRandNotesSaw"], 8), \midinote, Pfunc({
	(~filterNote.() ).postln;
}), \dur, 0.04, \amp, 0.6, \ctranspose, 12, \pan, 0);

~patIn20_2 = Pbind(\instrument, Prand(["playRandNotesSaw"], 2), \midinote, Pfunc({
	(~filterNote.() ).postln;
}), \dur, 0.04, \amp, 0.6, \ctranspose, 12, \pan, 0);

~patIn20_3 = Pbind(\instrument, Prand(["playRandNotesSaw"], 6), \midinote, Pfunc({
	(~filterNote.() ).postln;
}), \dur, 0.04, \amp, 0.6, \ctranspose, 12, \pan, 0);

~patIn20_4 = Pbind(\instrument, Prand(["playRandNotesSaw"], 7), \midinote, Pfunc({
	(~filterNote.() ).postln;
}), \dur, 0.04, \amp, 0.6, \ctranspose, 12, \pan, 0);

~patIn20_5 = Pbind(\instrument, Prand(["playRandNotesSaw"], 100), \midinote, Pfunc({
	(~filterNote.() ).postln;
}), \dur, 0.04, \amp, Pseq(~decresIn20, 1), \ctranspose, 12, \pan, 0);
)

(
r = Routine {
	~patIn20_1.play;
	1.yield;
	~patIn20_2.play;
	1.yield;
	~patIn20_3.play;
	1.yield;
	~patIn20_4.play;
	1.yield;
	~patIn20_5.play;
}.play;
)





//// 21
// ele note with large beating "swells", D# with Eb clarinet; 4" = 4 swells
~sineIn21 = {SinOsc.ar(155.563, 1, 0.25) + SinOsc.ar(156.563, 0, 0.25)}.play;





//// 22
// SineCut high register without beating 2"
(
~noteIn22 = Pbind(\instrument, Prand(["playRandNotesSineCut"], 1), \midinote, Pfunc({
	(~filterNote.() *1.15).postln;
}), \dur, 0.02, \amp, 0.8, \pan, 0);
~noteIn22.play;
)







//// 23
// 3 notes, mid register, decrescendo
(
	~transposeArrIn23_decres = Array.fill(4, {rrand(-12, 24)});
// calculate amplitude
	~decresArrIn23 = (Array.series(4, 0.2, 0.166).round(0.00001)).reverse;
	~patIn23Decres = Pbind(\instrument, Prand(["playRandNotesSaw"], 4), \midinote, Pfunc({
	(~filterNote.() ).postln;
}), \dur, 0.1, \amp, Pseq(~decresArrIn23, 1), \ctranspose, Pseq(~transposeArrIn23_decres, 1), \pan, 0);
~patIn23Decres.play;
)







//// 24
(
	~transposeArrIn24_decres = Array.fill(4, {rrand(-12, 30)});
// calculate amplitude
	~decresArrIn24 = (Array.series(4, 0.2, 0.166).round(0.00001)).reverse;
~patIn24Decres = Pbind(\instrument, Prand(["playRandNotesSine"], 4), \midinote, Pfunc({
	(~filterNote.() ).postln;
}), \dur, 0.1, \amp, Pseq(~decresArrIn24, 1), \ctranspose, Pseq(~transposeArrIn24_decres, 1), \pan, 0);
~patIn24Decres.play;
)







//// 25
(
	~transposeArrIn25_decres = Array.fill(2, {rrand(1, 24)});
// calculate amplitude
	~decresArrIn25 = (Array.series(2, 0.2, 0.166).round(0.00001)).reverse;
	~patIn25Decres = Pbind(\instrument, Prand(["playRandNotesSine"], 2), \midinote, Pfunc({
	(~filterNote.() ).postln;
}), \dur, 0.5, \amp, Pseq(~decresArrIn25, 1), \ctranspose, Pseq(~transposeArrIn25_decres, 1), \pan, 0);
~patIn25Decres.play;
)







//// 26
(
	~transposeArrIn26_decres = Array.fill(5, {rrand(1, 24)});
// calculate amplitude
	~decresArrIn26 = (Array.series(5, 0.2, 0.166).round(0.00001)).reverse;
	~patIn26Decres = Pbind(\instrument, Prand(["playRandNotesSaw3"], 5), \midinote, Pfunc({
	(~filterNote.() ).postln;
}), \dur, 0.2, \amp, Pseq(~decresArrIn26, 1), \ctranspose, Pseq(~transposeArrIn26_decres, 1), \pan, 0);
~patIn26Decres.play;
)





//// 27
(
~noteIn27_cut2 = Pbind(\instrument, Prand(["playRandNotesSineCut2"], 1), \midinote, 51, \dur, 1, \amp, 0.7, \pan, 0);
~noteIn27_cut2.play;
)





//// 28
// high long note; 4" fade out from beginning
(
~noteIn28 = Pbind(\instrument, Prand(["playRandNotesSineLong"], 1), \midinote, 79, \dur, 1, \amp, 0.7, \pan, 0);
~noteIn28.play;
)





//// 29
(
	~transposeArrIn29_decres = Array.fill(10, {rrand(1, 24)});
// calculate amplitude
	~decresArrIn29 = (Array.series(10, 0.03, 0.09).round(0.00001)).reverse;
	~patIn29Decres = Pbind(\instrument, Prand(["playRandNotesSaw"], 10), \midinote, Pfunc({
	(~filterNote.() ).postln;
}), \dur, 0.1, \amp, Pseq(~decresArrIn29, 1), \ctranspose, Pseq(~transposeArrIn29_decres, 1), \pan, 0);
~patIn29Decres.play;
)






//// 30
(
	~transposeArrIn30_decres = Array.fill(3, {rrand(1, 24)});
// calculate amplitude
	~decresArrIn30 = (Array.series(3, 0.08, 0.16).round(0.00001)).reverse;
	~ritIn30 = (Array.series(3, 0.2, 0.3));

	~patIn30Decres = Pbind(\instrument, Prand(["playRandNotesSine"], 3), \midinote, Pfunc({
	(~filterNote.() ).postln;
}), \dur, Pseq(~ritIn30, 1), \amp, Pseq(~decresArrIn30, 1), \ctranspose, Pseq(~transposeArrIn30_decres, 1), \pan, 0);
~patIn30Decres.play;
)






//// 31
(
	~transposeArrIn31_1 = Array.fill(5, {rrand(1, 24)});
	~transposeArrIn31_2 = Array.fill(3, {rrand(1, 24)});

	~decresArrIn31 = (Array.series(5, 0.03, 0.1).round(0.00001)).reverse;
	~cresArrIn31 = (Array.series(3, 0.1, 0.3).round(0.00001));

	~patIn31Decres = Pbind(\instrument, Prand(["playRandNotesSine"], 5), \midinote, Pfunc({
	(~filterNote.() ).postln;
}), \dur, 0.1, \amp, Pseq(~decresArrIn31, 1), \ctranspose, Pseq(~transposeArrIn31_1, 1), \pan, 0);

~patIn31Cres = Pbind(\instrument, Prand(["playRandNotesSaw"], 3), \midinote, Pfunc({
	(~filterNote.() ).postln;
}), \dur, 0.1, \amp, Pseq(~cresArrIn31, 1), \ctranspose, Pseq(~transposeArrIn31_2, 1), \pan, 0);
)

(
~routineIn31 = Routine {
	~patIn31Decres.play;
	2.yield;
	~patIn31Cres.play;
}.play;
)





//// 32
// 2, 5, and 1; each 1 beat
(
	~transposeArrIn32 = Array.fill(2, {rrand(1, 24)});
	~transposeArrIn32_2 = Array.fill(5, {rrand(-5, 24)});

	~decresArrIn32 = (Array.series(2, 0.2, 0.7).round(0.00001)).reverse;
	~cresArrIn32 = (Array.series(5, 0.1, 0.07).round(0.00001));

	~patIn32Decres = Pbind(\instrument, Prand(["playRandNotesSaw"], 2), \midinote, Pfunc({
	(~filterNote.() ).postln;
}), \dur, 0.1, \amp, Pseq(~decresArrIn32, 1), \ctranspose, Pseq(~transposeArrIn32, 1), \pan, 0);

~patIn32Cres = Pbind(\instrument, Prand(["playRandNotesSine"], 5), \midinote, Pfunc({
	(~filterNote.() ).postln;
}), \dur, 0.1, \amp, Pseq(~cresArrIn32, 1), \ctranspose, Pseq(~transposeArrIn32_2, 1), \pan, 0);

~patIn32_1note = Pbind(\instrument, Prand(["playRandNotesSaw"], 1), \midinote, Pfunc({
	(~filterNote.() ).postln;
}), \dur, 0.1, \amp, 0.9, \ctranspose, 12, \pan, 0);
)

(
~routineIn32 = Routine {
	~patIn32Decres.play;
	1.yield;
	~patIn32Cres.play;
	1.yield;
	~patIn32_1note.play;
}.play;
)





//// 33
// 4, 3, 3, 5, 4 beats
(
	~transposeArrIn33_1 = Array.fill(4, {rrand(1, 24)});
	~transposeArrIn33_2 = Array.fill(3, {rrand(-5, 12)});
	~transposeArrIn33_3 = Array.fill(3, {rrand(1, 24)});
	~transposeArrIn33_4 = Array.fill(5, {rrand(-12, 1)});
	~transposeArrIn33_5 = Array.fill(4, {rrand(1, 36)});

	~decresArrIn33_1 = (Array.series(4, 0.2, 0.15).round(0.00001)).reverse;
	~cresArrIn33_2 = (Array.series(3, 0.1, 0.25).round(0.00001));
	~decresArrIn33_3 = (Array.series(3, 0.2, 0.2).round(0.00001)).reverse;
	~cresArrIn33_4 = (Array.series(5, 0.1, 0.2).round(0.00001));
	~cresArrIn33_5 = (Array.series(4, 0.1, 0.26).round(0.00001));

	~patIn33_1 = Pbind(\instrument, Prand(["playRandNotesSine"], 4), \midinote, Pfunc({
	(~filterNote.() ).postln;
}), \dur, 0.1, \amp, Pseq(~decresArrIn33_1, 1), \ctranspose, Pseq(~transposeArrIn33_1, 1), \pan, 0);

	~patIn33_2 = Pbind(\instrument, Prand(["playRandNotesSaw"], 3), \midinote, Pfunc({
	(~filterNote.() ).postln;
}), \dur, 0.1, \amp, Pseq(~cresArrIn33_2, 1), \ctranspose, Pseq(~transposeArrIn33_2, 1), \pan, 0);

	~patIn33_3 = Pbind(\instrument, Prand(["playRandNotesSine"], 3), \midinote, Pfunc({
	(~filterNote.() ).postln;
}), \dur, 0.1, \amp, Pseq(~decresArrIn33_3, 1), \ctranspose, Pseq(~transposeArrIn33_3, 1), \pan, 0);

	~patIn33_4 = Pbind(\instrument, Prand(["playRandNotesSaw"], 5), \midinote, Pfunc({
	(~filterNote.() ).postln;
}), \dur, 0.1, \amp, Pseq(~cresArrIn33_4, 1), \ctranspose, Pseq(~transposeArrIn33_4 , 1), \pan, 0);

	~patIn33_5 = Pbind(\instrument, Prand(["playRandNotesSaw2"], 4), \midinote, Pfunc({
	(~filterNote.() ).postln;
}), \dur, 0.1, \amp, Pseq(~cresArrIn33_5, 1), \ctranspose, Pseq(~transposeArrIn33_5 , 1), \pan, 0);

)

(
~routineIn33 = Routine {
	~patIn33_1 .play;
	1.yield;
	~patIn33_2.play;
	1.yield;
	~patIn33_3.play;
	1.yield;
	~patIn33_4.play;
	1.yield;
	~patIn33_5.play;
}.play;
)





//// 34
(
	~decresArrIn34_1 = (Array.series(5, 0.2, 0.15).round(0.00001)).reverse;
	~cresArrIn34_2 = (Array.series(6, 0.1, 0.15).round(0.00001));
	~cresArrIn34_3 = (Array.series(4, 0.2, 0.2).round(0.00001));
	~cresArrIn34_4 = (Array.series(7, 0.1, 0.12).round(0.00001));
	~decresArrIn34_5 = (Array.series(8, 0.1, 0.1).round(0.00001)).reverse;

	~transposeArrIn34_1 = Array.fill(5, {rrand(1, 24)});
	~transposeArrIn34_2 = Array.fill(6, {rrand(-5, 12)});
	~transposeArrIn34_3 = Array.fill(4, {rrand(1, 24)});
	~transposeArrIn34_4 = Array.fill(7, {rrand(-12, 1)});
	~transposeArrIn34_5 = Array.fill(8, {rrand(1, 36)});

	~patIn34_1 = Pbind(\instrument, Prand(["playRandNotesSaw2"], 5), \midinote, Pfunc({
	(~filterNote.() ).postln;
}), \dur, 0.1, \amp, Pseq(~decresArrIn34_1, 1), \ctranspose, Pseq(~transposeArrIn34_1, 1), \pan, 0);

	~patIn34_2 = Pbind(\instrument, Prand(["playRandNotesSaw"], 6), \midinote, Pfunc({
	(~filterNote.() ).postln;
}), \dur, 0.1, \amp, Pseq(~cresArrIn34_2, 1), \ctranspose, Pseq(~transposeArrIn34_2, 1), \pan, 0);

	~patIn34_3 = Pbind(\instrument, Prand(["playRandNotesSine"], 4), \midinote, Pfunc({
	(~filterNote.() ).postln;
}), \dur, 0.1, \amp, Pseq(~cresArrIn34_3, 1), \ctranspose, Pseq(~transposeArrIn34_3, 1), \pan, 0);

	~patIn34_4 = Pbind(\instrument, Prand(["playRandNotesSaw2"], 7), \midinote, Pfunc({
	(~filterNote.() ).postln;
}), \dur, 0.1, \amp, Pseq(~cresArrIn34_4, 1), \ctranspose, Pseq(~transposeArrIn34_4 , 1), \pan, 0);

	~patIn34_5 = Pbind(\instrument, Prand(["playRandNotesSine"], 8), \midinote, Pfunc({
	(~filterNote.() ).postln;
}), \dur, 0.1, \amp, Pseq(~decresArrIn34_5, 1), \ctranspose, Pseq(~transposeArrIn34_5 , 1), \pan, 0);
)

(
~routineIn34 = Routine {
	~patIn34_1 .play;
	1.yield;
	~patIn34_2.play;
	1.yield;
	~patIn34_3.play;
	1.yield;
	~patIn34_4.play;
	1.yield;
	~patIn34_5.play;
}.play;
)





//// 35
(
	~decresArrIn35_1 = (Array.series(9, 0.1, 0.08).round(0.00001)).reverse;
	~cresArrIn35_2 = (Array.series(12, 0.1, 0.055).round(0.00001));
	~decresArrIn35_3 = (Array.series(15, 0.1, 0.035).round(0.00001)).reverse;
	~cresArrIn35_4 = (Array.series(18, 0.1, 0.035).round(0.00001));
	~cresArrIn35_5 = (Array.series(21, 0.1, 0.03).round(0.00001));

	~transposeArrIn35_1 = Array.fill(9, {rrand(-12, 24)});
	~transposeArrIn35_2 = Array.fill(12, {rrand(-5, 24)});
	~transposeArrIn35_3 = Array.fill(15, {rrand(1, 24)});
	~transposeArrIn35_4 = Array.fill(18, {rrand(1, 12)});
	~transposeArrIn35_5 = Array.fill(21, {rrand(5, 12)});

	~patIn35_1 = Pbind(\instrument, Prand(["playRandNotesSaw2"], 9), \midinote, Pfunc({
	(~filterNote.() ).postln;
}), \dur, 0.1, \amp, Pseq(~decresArrIn35_1, 1), \ctranspose, Pseq(~transposeArrIn35_1, 1), \pan, 0);

	~patIn35_2 = Pbind(\instrument, Prand(["playRandNotesSaw"], 12), \midinote, Pfunc({
	(~filterNote.() ).postln;
}), \dur, 0.1, \amp, Pseq(~cresArrIn35_2, 1), \ctranspose, Pseq(~transposeArrIn35_2, 1), \pan, 0);

	~patIn35_3 = Pbind(\instrument, Prand(["playRandNotesSine"], 15), \midinote, Pfunc({
	(~filterNote.() ).postln;
}), \dur, 0.06, \amp, Pseq(~decresArrIn35_3, 1), \ctranspose, Pseq(~transposeArrIn35_3, 1), \pan, 0);

	~patIn35_4 = Pbind(\instrument, Prand(["playRandNotesSaw2"], 18), \midinote, Pfunc({
	(~filterNote.() ).postln;
}), \dur, 0.05, \amp, Pseq(~cresArrIn35_4, 1), \ctranspose, Pseq(~transposeArrIn35_4 , 1), \pan, 0);

	~patIn35_5 = Pbind(\instrument, Prand(["playRandNotesSine"], 21), \midinote, Pfunc({
	(~filterNote.() ).postln;
}), \dur, 0.02, \amp, Pseq(~cresArrIn35_5, 1), \ctranspose, Pseq(~transposeArrIn35_5 , 1), \pan, 0);
)

(
~routineIn35 = Routine {
	~patIn35_1 .play;
	1.yield;
	~patIn35_2.play;
	1.yield;
	~patIn35_3.play;
	1.yield;
	~patIn35_4.play;
	1.yield;
	~patIn35_5.play;
}.play;
)





//// 36
// seamless continuous figure
(
	~decresArrIn36_1 = (Array.series(30, 0.1, 0.023).round(0.00001)).reverse;
	~cresArrIn36_2 = (Array.series(40, 0.1, 0.015).round(0.00001));

	~transposeArrIn36_1 = Array.fill(30, {rrand(1, 12)});
	~transposeArrIn36_2 = Array.fill(40, {rrand(1, 20)});

	~patIn36_1 = Pbind(\instrument, Prand(["playRandNotesSaw2"], 30), \midinote, Pfunc({
	(~filterNote.() ).postln;
}), \dur, 0.1, \amp, Pseq(~decresArrIn36_1, 1), \ctranspose, Pseq(~transposeArrIn36_1, 1), \pan, 0);

	~patIn36_2 = Pbind(\instrument, Prand(["playRandNotesSine"], 30), \midinote, Pfunc({
	(~filterNote.() ).postln;
}), \dur, 0.1, \amp, Pseq(~cresArrIn36_2, 1), \ctranspose, Pseq(~transposeArrIn36_2, 1), \pan, 0);
)

(
~routineIn36 = Routine {
	~patIn36_1.play;
	3.yield;
	~patIn36_2.play;
}.play;
)





//// 37
// seamless continuous figure
(
	~decresArrIn37_1 = (Array.series(40, 0.1, 0.012).round(0.00001)).reverse;
	~cresArrIn37_2 = (Array.series(50, 0.1, 0.014).round(0.00001));

	~transposeArrIn37_1 = Array.fill(40, {rrand(-5, 20)});
	~transposeArrIn37_2 = Array.fill(50, {rrand(-5, 20)});

	~patIn37_1 = Pbind(\instrument, Prand(["playRandNotesSine"], 40), \midinote, Pfunc({
	(~filterNote.() ).postln;
}), \dur, 0.1, \amp, Pseq(~decresArrIn37_1, 1), \ctranspose, Pseq(~transposeArrIn37_1, 1), \pan, 0);

	~patIn37_2 = Pbind(\instrument, Prand(["playRandNotesSaw2"], 50), \midinote, Pfunc({
	(~filterNote.() ).postln;
}), \dur, 0.1, \amp, Pseq(~cresArrIn37_2, 1), \ctranspose, Pseq(~transposeArrIn37_2, 1), \pan, 0);
)

(
~routineIn37 = Routine {
	~patIn37_1.play;
	~patIn37_2.play;
}.play;
)





//// 38
(
	~decresArrIn38_1 = (Array.series(30, 0.1, 0.023).round(0.00001)).reverse;
	~cresArrIn38_2 = (Array.series(34, 0.05, 0.023).round(0.00001));
	~decresArrIn38_3 = (Array.series(166, 0.1, 0.003).round(0.00001)).reverse;

	~transposeArrIn38_1 = Array.fill(30, {rrand(1, 12)});
	~transposeArrIn38_2 = Array.fill(34, {rrand(1, 20)});

	~transpose_temp = Array.fill(166, {rand(12, 24)});
	~glissHigh_temp = (Array.series(166, 0.1, 0.14));
	~transposeArrIn38_3 = ~transpose_temp * ~glissHigh_temp;

	~patIn38_1 = Pbind(\instrument, Prand(["playRandNotesSaw2"], 30), \midinote, Pfunc({
	(~filterNote.() ).postln;
}), \dur, 0.1, \amp, Pseq(~decresArrIn38_1, 1), \ctranspose, Pseq(~transposeArrIn38_1, 1), \pan, 0);

	~patIn38_2 = Pbind(\instrument, Prand(["playRandNotesSaw"], 34), \midinote, Pfunc({
	(~filterNote.() ).postln;
}), \dur, 0.06, \amp, Pseq(~cresArrIn38_2, 1), \ctranspose, Pseq(~transposeArrIn38_2, 1), \pan, 0);

~patIn38_3 = Pbind(\instrument, Prand(["playRandNotesSine"], 166), \midinote, Pfunc({
	(~filterNote.() ).postln;
}), \dur, 0.03, \amp, Pseq(~decresArrIn38_3, 1), \ctranspose, Pseq(~transposeArrIn38_3, 1), \pan, 0);
)

(
~routineIn38 = Routine {
	~patIn38_1.play;
	3.yield;
	~patIn38_2.play;
	2.yield;
	~patIn38_3.play;
}.play;
)





//// 39
(
	~cresArrIn39 = (Array.series(100, 0.05, 0.006).round(0.00001));
	~transposeArrIn39 = Array.fill(100, {rrand(12, 24)});

	~accelIn39 = (Array.series(100, 0.03, 0.00035)).reverse;

	~patIn39 = Pbind(\instrument, Prand(["playRandNotesSaw2"], 100), \midinote, Pfunc({
	(~filterNote.() ).postln;
}), \dur, Pseq(~accelIn39, 1), \amp, Pseq(~cresArrIn39, 1), \ctranspose, Pseq(~transposeArrIn39, 1), \pan, 0);

	~patIn39.play;
)





//// 40
(
	~decresArrIn40 = (Array.series(160, 0.05, 0.006).round(0.00001)).reverse;

	~transpose_tempIn40 = Array.fill(160, {rrand(1, 12)});
	~glissLow_tempIn40 = (Array.series(160, 0, 0.014)).reverse;
	~transposeArrIn40 = (~transpose_tempIn40 * ~glissLow_tempIn40);

	~patIn40 = Pbind(\instrument, Prand(["playRandNotesSaw"], 160), \midinote, Pfunc({
	(~filterNote.() ).postln;
}), \dur, 0.03, \amp, Pseq(~decresArrIn40, 1), \ctranspose, Pseq(~transposeArrIn40, 1), \pan, 0);

	~patIn40.play;
)





//// 41
(
	~cresArrIn41 = (Array.series(130, 0.05, 0.003).round(0.00001));

	~transpose_tempIn41 = Array.fill(130, {rrand(1, 12)});
	~glissHigh_tempIn41 = (Array.series(130, 0, 0.03));
	~transposeArrIn41 = (~transpose_tempIn41 * ~glissHigh_tempIn41);

	~accelIn41 = (Array.series(130, 0.01, 0.00038)).reverse;

	~patIn41 = Pbind(\instrument, Prand(["playRandNotesSine"], 130), \midinote, Pfunc({
	(~filterNote.() ).postln;
}), \dur, Pseq(~accelIn41, 1), \amp, Pseq(~cresArrIn41, 1), \ctranspose, Pseq(~transposeArrIn41, 1), \pan, 0);

	~patIn41.play;
)





//// 42
(
	~decresArrIn42 = (Array.series(130, 0.05, 0.003).round(0.00001)).reverse;

	~transpose_tempIn42 = Array.fill(130, {rrand(1, 10)});
	~glissLow_tempIn42 = (Array.series(130, 0, 0.03)).reverse;
	~transposeArrIn42 = (~transpose_tempIn42 * ~glissLow_tempIn42);


	~patIn42 = Pbind(\instrument, Prand(["playRandNotesSaw2"], 130), \midinote, Pfunc({
	(~filterNote.() ).postln;
}), \dur, 0.03, \amp, Pseq(~decresArrIn42, 1), \ctranspose, Pseq(~transposeArrIn42, 1), \pan, 0);

	~patIn42.play;
)





//// 43
(
	~decresArrIn43 = (Array.series(130, 0, 0.003).round(0.00001)).reverse;

	~transpose_tempIn43 = Array.fill(130, {rrand(1, 12)});
	~glissHigh_tempIn43 = (Array.series(130, 0, 0.03));
	~transposeArrIn43 = (~transpose_tempIn43 * ~glissHigh_tempIn43);

	~accelIn43 = (Array.series(130, 0.01, 0.00038)).reverse;

	~patIn43 = Pbind(\instrument, Prand(["playRandNotesSine"], 130), \midinote, Pfunc({
	(~filterNote.() ).postln;
}), \dur, Pseq(~accelIn43, 1), \amp, Pseq(~decresArrIn43, 1), \ctranspose, Pseq(~transposeArrIn43, 1), \pan, 0);

	~patIn43.play;
)





//// 44
(
	~decresArrIn44 = (Array.series(130, 0, 0.003).round(0.00001)).reverse;

	~transpose_tempIn44 = Array.fill(130, {rrand(1, 5)});
	~glissHigh_tempIn44 = (Array.series(130, 0, 0.03));
	~transposeArrIn44 = (~transpose_tempIn44 * ~glissHigh_tempIn44);

	~deaccelIn44 = (Array.series(130, 0.01, 0.0008));

	~patIn44 = Pbind(\instrument, Prand(["playRandNotesSaw2"], 130), \midinote, Pfunc({
	(~filterNote.() ).postln;
}), \dur, Pseq(~deaccelIn44, 1), \amp, Pseq(~decresArrIn44, 1), \ctranspose, Pseq(~transposeArrIn44, 1), \pan, 0);

	~patIn44.play;
)





//// 45

(
~clusterIn45_mid = Pbind(\instrument, Prand(["playRandNotesSine"], 1), \midinote, Pfunc({
	(~filterNote.() ).postln;
}), \dur, 0.02, \amp, 0.4, \ctranspose, 1, \pan, 0);
)

(
10.do {
	~clusterIn45_mid.play;
}
)





//// 46
(
~noteIn46_1 = Pbind(\instrument, Prand(["playRandNotesSine"], 1), \midinote, 63.5, \dur, 0.2, \amp, 0.4, \pan, 0);

~noteIn46_2 = Pbind(\instrument, Prand(["playRandNotesSineLong"], 1), \midinote, 63.45, \dur, 0.02, \amp, 0.8, \pan, 0);

~noteIn46_3 = Pbind(\instrument, Prand(["playRandNotesSine2"], 1), \midinote, 60, \dur, 0.2, \amp, 0.3, \pan, 0);
)

(
2.do {
	~noteIn46_1.play;
	~noteIn46_2.play;
	~noteIn46_3.play;
}
)





//// 47
(
~noteIn47_1 = Pbind(\instrument, Prand(["playRandNotesSine"], 1), \midinote, 63, \dur, 0.2, \amp, 0.4, \pan, 0);

~noteIn47_2 = Pbind(\instrument, Prand(["playRandNotesSaw2"], 1), \midinote, 63.5, \dur, 0.02, \amp, 0.8, \pan, 0);

~noteIn47_3 = Pbind(\instrument, Prand(["playRandNotesSine2"], 1), \midinote, 63.3, \dur, 0.2, \amp, 0.3, \pan, 0);

~noteIn47_4 = Pbind(\instrument, Prand(["playRandNotesSineCut"], 1), \midinote, 98, \dur, 0.02, \amp, 0.8, \pan, 0);
)

(
2.do {
	~noteIn47_1.play;
	~noteIn47_2.play;
	~noteIn47_3.play;
	~noteIn47_4.play;
}
)





//// 48
(
~noteIn48 = Pbind(\instrument, Prand(["playRandNotesSine"], 1), \midinote, 100, \dur, 0.2, \amp, 0.4, \pan, 0);
~noteIn48.play;
)





//// 49
(
~transposeArrIn49 = Array.fill(8, {rrand(1, 24)});
~noteIn49_1 = Pbind(\instrument, Prand(["playRandNotesSine"], 1), \midinote, 70, \dur, 0.2, \amp, 0.4, \pan, 0);
~patIn49_2 = Pbind(\instrument, Prand(["playRandNotesSaw2"], 8), \midinote, Pfunc({
	(~filterNote.() ).postln;
}), \dur, 0.1, \amp, 0.5, \ctranspose, Pseq(~transposeArrIn49, 1), \pan, 0);
)

(
~routineIn49 = Routine {
	~noteIn49_1.play;
	1.yield;
	~patIn49_2.play;
}.play;
)





//// 50
// taken from online example
(
SynthDef(\sfgrain, {arg bufnum=0, pan=0.0, startPos=0.0, amp=0.1, dur=0.04;
var grain;
grain= PlayBuf.ar(1,bufnum, BufRateScale.kr(bufnum), 1, BufFrames.ir(bufnum)*startPos, 0)*(EnvGen.kr(Env.perc(0.01,dur),doneAction:2)-0.001);
Out.ar(0,Pan2.ar(grain, pan))}).add;
)

b = Buffer.read(s, "/Users/shuyulin/Desktop/trioForClsEle/electronics/scripts/8_mono.wav");

//individual grain
Synth(\sfgrain,[\bufnum, b.bufnum, \startPos,rrand(0.0,1.0),\amp, exprand(0.005,0.1), \pan, 1.0.rand2]);

(
{
400.do{arg i;
var timeprop = (i/199.0)**3;
	Synth(\sfgrain,[\bufnum, b.bufnum, \startPos,rrand(0.0,timeprop),\amp, exprand(0.005,0.1), \pan, 1.0.rand2]);
	rrand((timeprop*0.1).max(0.01),timeprop*0.4).wait
};
}.fork
)





//// 51
// 2, 3, 12 notes
(
	~transposeArrIn51_1 = Array.fill(2, {rrand(1, 12)});
	~transposeArrIn51_2 = Array.fill(3, {rrand(1, 12)});
	~transposeArrIn51_3 = Array.fill(12, {rrand(1, 24)});

	~decresArrIn51_1 = (Array.series(2, 0.2, 0.3).round(0.00001)).reverse;
	~cresArrIn51_2 = (Array.series(3, 0.1, 0.25).round(0.00001));
	~cresArrIn51_3 = (Array.series(12, 0.2, 0.048).round(0.00001));

	~patIn51_1 = Pbind(\instrument, Prand(["playRandNotesSine"], 2), \midinote, Pfunc({
	(~filterNote.() ).postln;
}), \dur, 0.1, \amp, Pseq(~decresArrIn51_1, 1), \ctranspose, Pseq(~transposeArrIn51_1, 1), \pan, 0);

	~patIn51_2 = Pbind(\instrument, Prand(["playRandNotesSaw"], 3), \midinote, Pfunc({
	(~filterNote.() ).postln;
}), \dur, 0.1, \amp, Pseq(~cresArrIn51_2, 1), \ctranspose, Pseq(~transposeArrIn51_2, 1), \pan, 0);

	~patIn51_3 = Pbind(\instrument, Prand(["playRandNotesSine"], 12), \midinote, Pfunc({
	(~filterNote.() ).postln;
}), \dur, 0.083, \amp, Pseq(~cresArrIn51_3, 1), \ctranspose, Pseq(~transposeArrIn51_3, 1), \pan, 0);
)

(
~routineIn51 = Routine {
	~patIn51_1 .play;
	1.yield;
	~patIn51_2.play;
	1.yield;
	~patIn51_3.play;
}.play;
)





//// 52
// uses 8th track generated in the previous lines (8_mono) to generate sound track 52
(
SynthDef(\sfgrain, {arg bufnum=0, pan=0.0, startPos=0.0, amp=0.1, dur=0.04;
var grain;
grain= PlayBuf.ar(1,bufnum, BufRateScale.kr(bufnum), 1, BufFrames.ir(bufnum)*startPos, 0)*(EnvGen.kr(Env.perc(0.01,dur),doneAction:2)-0.001);
Out.ar(0,Pan2.ar(grain, pan))}).add;
)

b = Buffer.read(s, "/Users/shuyulin/Desktop/trioForClsEle/electronics/scripts/8_mono.wav");

//individual grain
Synth(\sfgrain,[\bufnum, b.bufnum, \startPos,rrand(0.0,1.0),\amp, exprand(0.005,0.1), \pan, 1.0.rand2]);

// controls slider to chnage sound
(
var w, slid, lastval;
lastval=0.0;
w=Window("My Window", Rect(100,500,200,200));
//A 200 by 200 window appears at screen co-ordinates (100, 500)
slid=Slider(w,Rect(10,10,150,40)); //a basic slider object
slid.action_({lastval= slid.value;}); //this is the callback- the function is called whenever you move the slider
{
inf.do{arg i;
var prop, timestart, timeend;
prop= (i%300)/300;
timestart= prop*0.8;
timeend= prop*(0.8+(0.1*lastval));
	Synth(\sfgrain,[\bufnum, b.bufnum, \startPos,rrand(timestart,timeend),\amp, exprand(0.005,0.1), \pan, lastval.rand2, \dur, 0.1+(lastval*0.5)]);
	//max in this to avoid ever going near 0.0 wait time, which would crash the computer!
	(((lastval*0.2)+0.01).max(0.01)).wait
};
}.fork;
w.front;
)





// 53
//// cluster to begin the next section after the electronics solo
(
~clusterIn53_high = Pbind(\instrument, Prand(["playRandNotesSine"], 1), \midinote, Pfunc({
	(~filterNote.() ).postln;
}), \dur, 0.02, \amp, 0.08, \ctranspose, 24, \pan, 0);

~clusterIn53_high2 = Pbind(\instrument, Prand(["playRandNotesSine"], 1), \midinote, Pfunc({
	(~filterNote.() ).postln;
}), \dur, 0.02, \amp, 0.5, \ctranspose, 12, \pan, 0);

~clusterIn53_mid = Pbind(\instrument, Prand(["playRandNotesSine"], 1), \midinote, Pfunc({
	(~filterNote.() ).postln;
}), \dur, 0.02, \amp, 0.6, \ctranspose, 1, \pan, 0);

~clusterIn53_low = Pbind(\instrument, Prand(["playRandNotesSine"], 1), \midinote, Pfunc({
	(~filterNote.() ).postln;
}), \dur, 0.02, \amp, 0.5, \ctranspose, -12, \pan, 0);

~clusterIn53_low2 = Pbind(\instrument, Prand(["playRandNotesSaw"], 1), \midinote, Pfunc({
	(~filterNote.() ).postln;
}), \dur, 0.02, \amp, 0.5, \ctranspose, -20, \pan, 0);
)

(
2.do {
	~clusterIn53_high.play;
	~clusterIn53_high_2.play;
	~clusterIn53_mid.play;
	~clusterIn53_mid.play;
	~clusterIn53_low.play;
	~clusterIn53_low2.play;
}
)





//// 54
(
	~decresArrIn54_1 = (Array.series(1000, 0, 0.0004).round(0.00001)).reverse;
	~decresArrIn54_2 = (Array.series(6, 0.1, 0.05).round(0.00001)).reverse;
	~decresArrIn54_3 = (Array.series(8, 0.1, 0.05).round(0.00001)).reverse;
	~decresArrIn54_4 = (Array.series(7, 0.1, 0.05).round(0.00001)).reverse;
	~decresArrIn54_5 = (Array.series(9, 0.1, 0.04).round(0.00001)).reverse;

	~transposeArrIn54_1 = Array.fill(500, {rrand(1, 24)});
	~transposeArrIn54_1_1 = Array.fill(1000, {rrand(1, 24)});
	~transposeArrIn54_2 = Array.fill(6, {rrand(-12, 1)});
	~transposeArrIn54_3 = Array.fill(8, {rrand(-12, 1)});
	~transposeArrIn54_4 = Array.fill(7, {rrand(-12, 1)});
	~transposeArrIn54_5 = Array.fill(9, {rrand(-12, 1)});

	~patIn54_1 = Pbind(\instrument, Prand(["playRandNotesSaw"], 500), \midinote, Pfunc({
	(~filterNote.() ).postln;
}), \dur, 0.01, \amp, 0.45, \ctranspose, Pseq(~transposeArrIn54_1, 1), \pan, 0);

	~patIn54_1_1 = Pbind(\instrument, Prand(["playRandNotesSaw"], 1000), \midinote, Pfunc({
	(~filterNote.() ).postln;
}), \dur, 0.01, \amp, Pseq(~decresArrIn54_1 , 1), \ctranspose, Pseq(~transposeArrIn54_1_1, 1), \pan, 0);

	~patIn54_2 = Pbind(\instrument, Prand(["playRandNotesSine2"], 6), \midinote, Pfunc({
	(~filterNote.() ).postln;
}), \dur, 0.05, \amp, Pseq(~decresArrIn54_2, 1), \ctranspose, Pseq(~transposeArrIn54_2, 1), \pan, 0);

	~patIn54_3 = Pbind(\instrument, Prand(["playRandNotesSaw2"], 8), \midinote, Pfunc({
	(~filterNote.() ).postln;
}), \dur, 0.05, \amp, Pseq(~decresArrIn54_3, 1), \ctranspose, Pseq(~transposeArrIn54_3, 1), \pan, 0);

	~patIn54_4 = Pbind(\instrument, Prand(["playRandNotesSine2"], 7), \midinote, Pfunc({
	(~filterNote.() ).postln;
}), \dur, 0.05, \amp, Pseq(~decresArrIn54_4, 1), \ctranspose, Pseq(~transposeArrIn54_4, 1), \pan, 0);

	~patIn54_5 = Pbind(\instrument, Prand(["playRandNotesSaw2"], 9), \midinote, Pfunc({
	(~filterNote.() ).postln;
}), \dur, 0.05, \amp, Pseq(~decresArrIn54_5, 1), \ctranspose, Pseq(~transposeArrIn54_5, 1), \pan, 0);
)

(
~routineIn54 = Routine {
	~patIn54_1.play;
	5.yield;
	~patIn54_1_1.play;
	~patIn54_2.play;
	~patIn54_5.play;
	~patIn54_3.play;
	~patIn54_3.play;
	//~sineIn54.play;
	1.yield;
	~patIn54_3.play;
	~patIn54_3.play;
	1.yield;
	~patIn54_4.play;
	~patIn54_3.play;
	~patIn54_3.play;
	1.yield;
	~patIn54_5.play;
	~patIn54_3.play;
	~patIn54_4.play;
}.play;
)





//// 55
// 1" swell play with bass clarinet; 54 fade out into this part
~sineIn55 = {SinOsc.ar(146.832, 0, 0.25) + SinOsc.ar(147.832, 0, 0.25)}.play;





//// 56
// another solo of electronics
// use 1_mono sound file generated from this code
(
SynthDef(\sfgrain, {arg bufnum=0, pan=0.0, startPos=0.0, amp=0.05, dur=0.04;
var grain;
grain= PlayBuf.ar(1,bufnum, BufRateScale.kr(bufnum), 1, BufFrames.ir(bufnum)*startPos, 0)*(EnvGen.kr(Env.perc(0.01,dur),doneAction:2)-0.001);
Out.ar(0,Pan2.ar(grain, pan))}).add;
)
b = Buffer.read(s, "/Users/shuyulin/Desktop/trioForClsEle/electronics/scripts/1_mono.wav");
//individual grain
Synth(\sfgrain,[\bufnum, b.bufnum, \startPos,rrand(0.0,1.0),\amp, exprand(0.005,0.1), \pan, 1.0.rand2]);
(
{
1000.do{arg i;
var timeprop = (i/800.0)**3;
	Synth(\sfgrain,[\bufnum, b.bufnum, \startPos,rrand(0.0,timeprop),\amp, exprand(0.005,0.1), \pan, 1.0.rand2]);
	rrand((timeprop*0.1).max(0.01),timeprop*0.4).wait
};
}.fork
)
(
var w, slid, lastval;
lastval=0.0;
w=Window("My Window", Rect(100,500,200,200));
//A 200 by 200 window appears at screen co-ordinates (100, 500)
slid=Slider(w,Rect(10,10,150,40)); //a basic slider object
slid.action_({lastval= slid.value;}); //this is the callback- the function is called whenever you move the slider
{
inf.do{arg i;
var prop, timestart, timeend;
prop= (i%300)/300;
timestart= prop*0.8;
timeend= prop*(0.8+(0.1*lastval));
	Synth(\sfgrain,[\bufnum, b.bufnum, \startPos,rrand(timestart,timeend),\amp, exprand(0.005,0.1), \pan, lastval.rand2, \dur, 0.1+(lastval*0.5)]);
	//max in this to avoid ever going near 0.0 wait time, which would crash the computer!
	(((lastval*0.2)+0.01).max(0.01)).wait
};
}.fork;
w.front;
)





//// 57
(
~notesIn57_high = Pbind(\instrument, Prand(["playRandNotesSine3"], 5), \midinote, Pfunc({
	(~filterNote.() ).postln;
}), \dur, 0.083, \amp, 0.1, \ctranspose, 24);

~notesIn57_mid= Pbind(\instrument, Prand(["playRandNotesSine3"], 5), \midinote, Pfunc({
	(~filterNote.() ).postln;
}), \dur, 0.083, \amp, 0.15, \ctranspose, 1);
)
(
r = Routine {
	~notesIn57_high.play;
	2.yield;
	~notesIn57_mid.play;
}.play;
)





//// 58
(
~cresArrIn58 = (Array.series(7, 0.05, 0.06).round(0.00001));

~notesIn58_mid = Pbind(\instrument, Prand(["playRandNotesSine3"], 6), \midinote, Pfunc({
	(~filterNote.() ).postln;
}), \dur, 0.05, \amp, 0.3, \ctranspose, 1);

~notesIn58_high = Pbind(\instrument, Prand(["playRandNotesSaw4"], 7), \midinote, Pfunc({
	(~filterNote.() ).postln;
}), \dur, 0.07, \amp, Pseq(~cresArrIn58, 1), \ctranspose, 12);
)
(
~routineIn58 = Routine {
	~notesIn58_mid.play;
	2.yield;
	~notesIn58_high.play;
}.play;
)





//// 59
(
~decresArrIn59 = (Array.series(7, 0.1, 0.1).round(0.00001)).reverse;

~notesIn59_mid = Pbind(\instrument, Prand(["playRandNotesSaw4"], 4), \midinote, Pfunc({
	(~filterNote.() ).postln;
}), \dur, 0.07, \amp, 0.1, \ctranspose, 1);

~notesIn59_low = Pbind(\instrument, Prand(["playRandNotesSaw2"], 7), \midinote, Pfunc({
	(~filterNote.() ).postln;
}), \dur, 0.1, \amp, Pseq(~decresArrIn59, 1), \ctranspose, -5);
)
(
~routineIn59 = Routine {
	~notesIn59_mid.play;
	3.yield;
	~notesIn59_low.play;
}.play;
)





//// 60
(
~cresArrIn60_1 = (Array.series(8, 0.1, 0.1).round(0.00001));
~highLow_temp = (Array.series(8, -24, 5)).reverse;
~transposeArrIn60_highLow = Array.fill(8, {rrand(24, -12)}) + ~highLow_temp;

~cresArrIn60_2 = (Array.series(10, 0.2, 0.05).round(0.00001));
~lowHigh_temp = (Array.series(10, -12, 4));
~transposeArrIn60_lowHigh = Array.fill(8, {rrand(-5, 5)}) + ~lowHigh_temp;

~notesIn60_mid = Pbind(\instrument, Prand(["playRandNotesSine3"], 8), \midinote, Pfunc({
	(~filterNote.() ).postln;
}), \dur, 0.07, \amp, 0.6, \ctranspose, 1);

~notesIn60_highLow = Pbind(\instrument, Prand(["playRandNotesSaw2"], 8), \midinote, Pfunc({
	(~filterNote.() ).postln;
}), \dur, 0.1, \amp, Pseq(~cresArrIn60_1, 1), \ctranspose, Pseq(~transposeArrIn60_highLow, 1));

~notesIn60_lowHigh = Pbind(\instrument, Prand(["playRandNotesSine"], 8), \midinote, Pfunc({
	(~filterNote.() ).postln;
}), \dur, 0.1, \amp, Pseq(~cresArrIn60_2, 1), \ctranspose, Pseq(~transposeArrIn60_lowHigh, 1));
)
(
~routineIn60 = Routine {
	~notesIn60_mid.play;
	2.yield;
	~notesIn60_highLow.play;
	2.yield;
	~notesIn60_lowHigh.play;
}.play;
)





//// 61
(
~cresArrIn61 = (Array.series(10, 0.2, 0.05).round(0.00001));
~midHighTransposeArrIn61 = (Array.series(10, 1, 2.5));

~notesIn61_midHigh = Pbind(\instrument, Prand(["playRandNotesSine3"], 10), \midinote, Pfunc({
	(~filterNote.() ).postln;
}), \dur, 0.1, \amp, Pseq(~cresArrIn61, 1), \ctranspose, Pseq(~midHighTransposeArrIn61, 1));

~notesIn61_midHigh.play;
)





//// 62
(
~sineIn62_as_low = {SinOsc.ar(233.081, 1, 0.01) + SinOsc.ar(233.081, 0, 0.01)}.play;
~sineIn62_as_mid = {SinOsc.ar(466.163, 1, 0.1) + SinOsc.ar(467.163, 0, 0.1)}.play;
~sineIn62_a = {SinOsc.ar(440, 1, 0.04) + SinOsc.ar(442, 0, 0.04)}.play;
~sineIn62_gs = {SinOsc.ar(415.304, 1, 0.03) + SinOsc.ar(414.304, 0, 0.03)}.play;
~sineIn62_g = {SinOsc.ar(391.995, 1, 0.02) + SinOsc.ar(389.995, 0, 0.02)}.play;
~sineIn62_fs = {SinOsc.ar(369.994, 1, 0.01) + SinOsc.ar(371.994, 0, 0.01)}.play;
)





//// 63
(
~sineIn63_a_mid = {SinOsc.ar(440, 1, 0.04) + SinOsc.ar(442, 0, 0.04)}.play;
~sineIn63_a_low = {SinOsc.ar(440, 1, 0.04) + SinOsc.ar(442, 0, 0.04)}.play;
~sineIn63_gs = {SinOsc.ar(415.304, 1, 0.03) + SinOsc.ar(414.304, 0, 0.03)}.play;
~sineIn63_g = {SinOsc.ar(391.995, 1, 0.02) + SinOsc.ar(389.995, 0, 0.02)}.play;
~sineIn63_fs = {SinOsc.ar(369.994, 1, 0.01) + SinOsc.ar(371.994, 0, 0.01)}.play;
~sineIn63_f = {SinOsc.ar(349.228, 1, 0.01) + SinOsc.ar(349.228, 0, 0.01)}.play;
)





//// 64
(
~sineIn64_gs = {SinOsc.ar(415.304, 1, 0.04) + SinOsc.ar(414.304, 0, 0.04)}.play;
~sineIn64_gs_low = {SinOsc.ar(207.652, 1, 0.02) + SinOsc.ar(205.652, 0, 0.02)}.play;
~sineIn64_g = {SinOsc.ar(391.995, 1, 0.02) + SinOsc.ar(389.995, 0, 0.02)}.play;
~sineIn64_fs = {SinOsc.ar(369.994, 1, 0.01) + SinOsc.ar(371.994, 0, 0.01)}.play;
~sineIn64_f = {SinOsc.ar(349.228, 1, 0.01) + SinOsc.ar(349.228, 0, 0.01)}.play;
~sineIn64_e = {SinOsc.ar(329.627, 1, 0.01) + SinOsc.ar(329.627, 0, 0.01)}.play;
)





//// 65
(
~sineIn65_g = {SinOsc.ar(391.995, 1, 0.02) + SinOsc.ar(389.995, 0, 0.02)}.play;
~sineIn65_g_low = {SinOsc.ar(391.995, 1, 0.01) + SinOsc.ar(389.995, 0, 0.01)}.play;
~sineIn65_g_high = {SinOsc.ar(391.995, 1, 0.008) + SinOsc.ar(389.995, 0, 0.008)}.play;
~sineIn65_fs = {SinOsc.ar(369.994, 1, 0.008) + SinOsc.ar(371.994, 0, 0.008)}.play;
~sineIn65_f = {SinOsc.ar(349.228, 1, 0.008) + SinOsc.ar(349.228, 0, 0.008)}.play;
~sineIn65_e = {SinOsc.ar(329.627, 1, 0.008) + SinOsc.ar(329.627, 0, 0.008)}.play;
~sineIn65_ds = {SinOsc.ar(311.126, 1, 0.008) + SinOsc.ar(308.126, 0, 0.008)}.play;
)





//// 66
(
~sineIn66_fs = {SinOsc.ar(369.994, 1, 0.01) + SinOsc.ar(371.994, 0, 0.01)}.play;
~sineIn66_fs_low = {SinOsc.ar(184.997, 1, 0.01) + SinOsc.ar(184.997, 0, 0.01)}.play;
~sineIn66_fs_high = {SinOsc.ar(739.988, 1, 0.0008) + SinOsc.ar(740.988, 0, 0.0008)}.play;
~sineIn66_f = {SinOsc.ar(349.228, 1, 0.008) + SinOsc.ar(349.228, 0, 0.008)}.play;
~sineIn66_e = {SinOsc.ar(329.627, 1, 0.008) + SinOsc.ar(329.627, 0, 0.008)}.play;
~sineIn66_ds = {SinOsc.ar(311.126, 1, 0.008) + SinOsc.ar(310.126, 0, 0.008)}.play;
~sineIn66_d = {SinOsc.ar(293.664, 1, 0.008) + SinOsc.ar(293.664, 0, 0.008)}.play;
~sineIn66_cs = {SinOsc.ar(277.182, 1, 0.008) + SinOsc.ar(277.182, 0, 0.008)}.play;
)





//// 67
(
~clusterIn67_high = Pbind(\instrument, Prand(["playRandNotesSine3"], 1), \midinote, Pfunc({
	(~filterNote.() ).postln;
}), \dur, 0.02, \amp, 0.05, \ctranspose, 24, \pan, 0);

~clusterIn67_high2 = Pbind(\instrument, Prand(["playRandNotesSine3"], 1), \midinote, Pfunc({
	(~filterNote.() ).postln;
}), \dur, 0.02, \amp, 0.4, \ctranspose, 12, \pan, 0);

~clusterIn67_mid = Pbind(\instrument, Prand(["playRandNotesSaw2"], 1), \midinote, Pfunc({
	(~filterNote.() ).postln;
}), \dur, 0.02, \amp, 0.5, \ctranspose, 1, \pan, 0);

~clusterIn67_low = Pbind(\instrument, Prand(["playRandNotesSine"], 1), \midinote, Pfunc({
	(~filterNote.() ).postln;
}), \dur, 0.02, \amp, 0.4, \ctranspose, -12, \pan, 0);

~clusterIn67_low2 = Pbind(\instrument, Prand(["playRandNotesSine3"], 1), \midinote, Pfunc({
	(~filterNote.() ).postln;
}), \dur, 0.02, \amp, 0.4, \ctranspose, -20, \pan, 0);
)
(
3.do {
	~clusterIn67_high.play;
	~clusterIn67_high2.play;
	~clusterIn67_mid.play;
	~clusterIn67_mid.play;
	~clusterIn67_low.play;
	~clusterIn67_low2.play;
}
)





//// 68
// high register runs 4" crescendo and 6" decrescendo; 3" fade out
// mid and low register fast runs to imitate clarinets runs that will come in later

(
~cresArrIn68_high = (Array.series(400, 0.1, 0.00175).round(0.00001));
~decresArrIn68_high = (Array.series(600, 0.1, 0.00116).round(0.00001)).reverse;
~fadeOutAmpIn68 = (Array.series(300, 0, 0.00033).round(0.00001)).reverse;
~ampArrIn68 = ~cresArrIn68_high ++ ~decresArrIn68_high ++ ~fadeOutAmpIn68;
~fadeOutDurArrIn68 = Array.series(300, 0.01, 0.0001);
~durArrIn68 = Array.series(1000, 0.01, 0) ++ ~fadeOutDurArrIn68;
~notesIn68_high = Pbind(\instrument, Prand(["playRandNotesSine2"], 1300), \midinote, Pfunc({
	(~filterNote.() ).postln;
}), \dur, Pseq(~durArrIn68, 1), \amp, Pseq(~ampArrIn68, 1), \ctranspose, 48);

// mid-high register run come in on the 5th beat; each 0.2 sec
~transpose_tempIn68_high = Array.fill(20, {rrand(1, 5)});
~glissHigh_tempIn68_high = (Array.series(20, 3, 0.1)).reverse;
~transposeArrIn68_high = (~transpose_tempIn68_high * ~glissHigh_tempIn68_high);
~patIn68_high = Pbind(\instrument, Prand(["playRandNotesSine3"], 20), \midinote, Pfunc({
	(~filterNote.() ).postln;
}), \dur, 0.01, \amp, 0.2, \ctranspose, Pseq(~transposeArrIn68_high, 1), \pan, 0);

// low register run come in on the 5th beat; each 0.2 sec
~transpose_tempIn68_low = Array.fill(20, {rrand(1, 5)});
~glissLow_tempIn68_low = (Array.series(20, 3, 0.03));
~transposeArrIn68_low = (~transpose_tempIn68_low * ~glissLow_tempIn68_low);
~patIn68_low = Pbind(\instrument, Prand(["playRandNotesSine3"], 20), \midinote, Pfunc({
	(~filterNote.() ).postln;
}), \dur, 0.01, \amp, 0.2, \ctranspose, Pseq(~transposeArrIn68_low, 1), \pan, 0);

// high to low register run come in on the 1st beat of next bar
	~transpose_tempIn68_highLow = Array.fill(20, {rrand(1, 5)});
	~glissHigh_tempIn68_highLow = (Array.series(20, 0, 0.4)).reverse;
	~transposeArrIn68_highLow = ~transpose_tempIn68_highLow * ~glissHigh_tempIn68_highLow;
	~deaccelIn68_highLow = (Array.series(20, 0.01, 0.01));
	~patIn68_highLow = Pbind(\instrument, Prand(["playRandNotesSaw3"], 20), \midinote, Pfunc({
	(~filterNote.() ).postln;
}), \dur, Pseq(~deaccelIn68_highLow, 1), \amp, 0.4, \ctranspose, Pseq(~transposeArrIn68_highLow, 1), \pan, 0);

// low to mid for 1.5 sec
~transposeArr_lowMid = Array.series(30, -1, 0.3);
~patIn68_lowMid = Pbind(\instrument, Prand(["playRandNotesSaw"], 30), \midinote, Pfunc({
	(~filterNote.() ).postln;
}), \dur, 0.05, \amp, 0.5, \ctranspose, Pseq(~transposeArr_lowMid, 1), \pan, 0);

// mid to high for 1.5 sec
~transposeArr_midHigh = Array.series(30, 1, 0.3);
~patIn68_midHigh = Pbind(\instrument, Prand(["playRandNotesSine3"], 30), \midinote, Pfunc({
	(~filterNote.() ).postln;
}), \dur, 0.05, \amp, 0.4, \ctranspose, Pseq(~transposeArr_midHigh, 1), \pan, 0);
)
(
~routineIn68 = Routine {
	~notesIn68_high.play;
	4.yield;
	~patIn68_high.play;
	0.35.yield;
	~patIn68_low.play;
	0.7.yield;
	~patIn68_highLow.play;
	2.yield;
	~patIn68_lowMid.play;
	1.6.yield;
	~patIn68_midHigh.play;
}.play;
)





//// 69
(
~cresArrIn69_toHigh = (Array.series(100, 0.1, 0.003).round(0.00001)).reverse;
~patIn69_high = Pbind(\instrument, Prand(["playRandNotesSineCut"], 100), \midinote, Pfunc({
	(~filterNote.() ).postln;
}), \dur, 0.05, \amp, Pseq(~cresArrIn69_toHigh, 1), \ctranspose, 12, \pan, 0);

~decresArrIn69_highLow = (Array.series(71, 0.02, 0.003).round(0.00001)).reverse;
~transpose_tempIn69_highLow = Array.fill(71, {rrand(1, 5)});
~gliss_tempIn69_highLow = (Array.series(71, -0.8, 0.1)).reverse;
~transposeArrIn69_highLow = (~transpose_tempIn69_highLow * ~gliss_tempIn69_highLow);
~patIn69_highLow = Pbind(\instrument, Prand(["playRandNotesSineCut"], 71), \midinote, Pfunc({
	(~filterNote.() ).postln;
}), \dur, 0.07, \amp, Pseq(~decresArrIn69_highLow , 1), \ctranspose, Pseq(~transposeArrIn69_highLow, 1), \pan, 0);

// 5" gliss p > ppppp
~decresArrIn69_midLow = (Array.series(71, 0.2, 0.0025).round(0.00001)).reverse;
~transpose_tempIn69_midLow = Array.fill(71, {rrand(1, 5)});
~gliss_tempIn69_midLow = (Array.series(71, -0.8, 0.1)).reverse;
~transposeArrIn69_midLow = (~transpose_tempIn69_midLow * ~gliss_tempIn69_midLow);

~patIn69_midLow = Pbind(\instrument, Prand(["playRandNotesSineCut2"], 71), \midinote, Pfunc({
	(~filterNote.() ).postln;
}), \dur, 0.07, \amp, Pseq(~decresArrIn69_midLow , 1), \ctranspose, Pseq(~transposeArrIn69_midLow, 1), \pan, 0);

// 5" rit fade out completely
~decresArrIn69_fadeOut = (Array.series(71, 0, 0.003).round(0.00001)).reverse;
~transpose_tempIn69_fadeOut = Array.fill(71, {rrand(1, 5)});
~gliss_tempIn69_fadeOut = (Array.series(71, -0.8, 0.1)).reverse;
~transposeArrIn69_fadeOut = (~transpose_tempIn69_fadeOut * ~gliss_tempIn69_fadeOut);
~durIn69_rit = Array.series(71, 0.07, 0.001);

~patIn69_fadeOut= Pbind(\instrument, Prand(["playRandNotesSineCut2"], 71), \midinote, Pfunc({
	(~filterNote.() ).postln;
}), \dur, Pseq(~durIn69_rit, 1), \amp, Pseq(~decresArrIn69_fadeOut , 1), \ctranspose, Pseq(~transposeArrIn69_fadeOut, 1), \pan, 0);
)

(
~routineIn69 = Routine {
	~patIn69_high.play;
	5.yield;
	~patIn69_highLow.play;
	5.yield;
	~patIn69_midLow.play;
	5.yield;
	~patIn69_fadeOut.play;
}.play;
)





//// 70
// 3 times sf > p upward gliss
// 1st time high-mid;
// 2nd time high-mid;
// 3rd time mid-low
(
~decresArrIn70_1 = (Array.series(8, 0.1, 0.1).round(0.00001)).reverse;
~highMid_temp = (Array.series(8, 1, 3));
~transposeArrIn70_highMid = Array.fill(8, {rrand(1, 3)}) + ~highMid_temp;

~cresArrIn70_2 = (Array.series(8, 0.1, 0.06).round(0.00001));
~highMid2_temp = (Array.series(8, 10, 4));
~transposeArrIn70_highMid2 = Array.fill(8, {rrand(1, 3)}) + ~highMid2_temp;

~decresArrIn70_3 = (Array.series(8, 0.02, 0.13).round(0.00001)).reverse;
~midLow_temp = (Array.series(8, -10, 4));
~transposeArrIn70_midLow = Array.fill(8, {rrand(1, 5)}) + ~midLow_temp;

~notesIn70_highMid = Pbind(\instrument, Prand(["playRandNotesSine3"], 8), \midinote, Pfunc({
	(~filterNote.() ).postln;
}), \dur, 0.07, \amp, Pseq(~decresArrIn70_1 , 1), \ctranspose, Pseq(~transposeArrIn70_highMid, 1));

~notesIn70_highMid2 = Pbind(\instrument, Prand(["playRandNotesSine3"], 8), \midinote, Pfunc({
	(~filterNote.() ).postln;
}), \dur, 0.07, \amp, Pseq(~cresArrIn70_2, 1), \ctranspose, Pseq(~transposeArrIn70_highMid2, 1));

~notesIn70_midLow = Pbind(\instrument, Prand(["playRandNotesSaw"], 8), \midinote, Pfunc({
	(~filterNote.() ).postln;
}), \dur, 0.07, \amp, Pseq(~decresArrIn70_3, 1), \ctranspose, Pseq(~transposeArrIn70_midLow, 1));
)
(
~routineIn70 = Routine {
	~notesIn70_highMid.play;
	1.yield;
	~notesIn70_highMid2.play;
	1.yield;
	~notesIn70_midLow.play;
}.play;
)





//// 71
// 8 seconds from high to low
// short, sporadic runs
(
~cresArrIn71_1 = (Array.series(8, 0.05, 0.1).round(0.00001));
~decresArrIn71_2 = (Array.series(6, 0.1, 0.15).round(0.00001)).reverse;
~cresArrIn71_3 = (Array.series(4, 0.1, 0.2).round(0.00001));
~decresArrIn71_4 = (Array.series(8, 0.1, 0.1).round(0.00001)).reverse;
~cresArrIn71_6 = (Array.series(7, 0.05, 0.1).round(0.00001));
~decresArrIn71_7 = (Array.series(8, 0.1, 0.1).round(0.00001)).reverse;
~decresArrIn71_8 = (Array.series(12, 0.1, 0.07).round(0.00001)).reverse;

~notesIn71_1 = Pbind(\instrument, Prand(["playRandNotesSaw"], 8), \midinote, Pfunc({
	(~filterNote.() ).postln;
}), \dur, 0.07, \amp, Pseq(~cresArrIn71_1 , 1), \ctranspose, 28);

~notesIn71_2 = Pbind(\instrument, Prand(["playRandNotesSaw"], 6), \midinote, Pfunc({
	(~filterNote.() ).postln;
}), \dur, 0.1, \amp, Pseq(~decresArrIn71_2, 1), \ctranspose, -12);

~notesIn71_3 = Pbind(\instrument, Prand(["playRandNotesSine3"], 4), \midinote, Pfunc({
	(~filterNote.() ).postln;
}), \dur, 0.1, \amp, Pseq(~cresArrIn71_3, 1), \ctranspose, 12);

~notesIn71_4 = Pbind(\instrument, Prand(["playRandNotesSaw"], 8), \midinote, Pfunc({
	(~filterNote.() ).postln;
}), \dur, 0.1, \amp, Pseq(~decresArrIn71_4, 1), \ctranspose, 1);

~notesIn71_5 = Pbind(\instrument, Prand(["playRandNotesSine3"], 10), \midinote, Pfunc({
	(~filterNote.() ).postln;
}), \dur, 0.065, \amp, 0.3, \ctranspose, 12);

~notesIn71_6 = Pbind(\instrument, Prand(["playRandNotesSaw"], 7), \midinote, Pfunc({
	(~filterNote.() ).postln;
}), \dur, 0.1, \amp, Pseq(~cresArrIn71_6, 1), \ctranspose, 12);

~notesIn71_7 = Pbind(\instrument, Prand(["playRandNotesSine3"], 8), \midinote, Pfunc({
	(~filterNote.() ).postln;
}), \dur, 0.08, \amp, Pseq(~decresArrIn71_7, 1), \ctranspose, 1);

~notesIn71_8 = Pbind(\instrument, Prand(["playRandNotesSine"], 12), \midinote, Pfunc({
	(~filterNote.() ).postln;
}), \dur, 0.08, \amp, Pseq(~decresArrIn71_8, 1), \ctranspose, -10);
)

(
~routineIn71 = Routine {
	~notesIn71_1.play;
	1.yield;
	~notesIn71_2.play;
	1.yield;
	~notesIn71_3.play;
	1.yield;
	~notesIn71_4.play;
	1.yield;
	~notesIn71_5.play;
	1.yield;
	~notesIn71_6.play;
	1.yield;
	~notesIn71_7.play;
	1.yield;
	~notesIn71_8.play;
}.play;
)





//// 72
(
~cresArrIn72 = (Array.series(62, 0.05, 0.0125).round(0.00001));
~notesIn72 = Pbind(\instrument, Prand(["playRandNotesSine"], 62), \midinote, Pfunc({
	(~filterNote.() ).postln;
}), \dur, 0.08, \amp, Pseq(~cresArrIn72, 1), \ctranspose, -12);
~notesIn72.play;
)






//// 73
(
~decresArrIn73 = (Array.series(20, 0.02, 0.03).round(0.00001)).reverse;
~notesIn73 = Pbind(\instrument, Prand(["playRandNotesSine3"], 20), \midinote, Pfunc({
	(~filterNote.() ).postln;
}), \dur, 0.05, \amp, Pseq(~decresArrIn73, 1), \ctranspose, 12);
~notesIn73.play;
)






//// 74
// electronics solo for 5 seconds
(
~notesIn74_1 = Pbind(\instrument, Prand(["playRandNotesSine3"], 5), \midinote, Pfunc({
	(~filterNote.() ).postln;
}), \dur, 0.03, \amp, 0.08, \ctranspose, 24);

~notesIn74_2 = Pbind(\instrument, Prand(["playRandNotesSine3"], 5), \midinote, Pfunc({
	(~filterNote.() ).postln;
}), \dur, 0.03, \amp, 0.6, \ctranspose, -12);

~cresArrIn74_gliss1 = (Array.series(8, 0.02, 0.1).round(0.00001));
~transposeArrIn74_gliss1 = (Array.series(8, 1, 4).round(0.00001));
~glissIn74_1 = Pbind(\instrument, Prand(["playRandNotesSaw"], 8), \midinote, Pfunc({
	(~filterNote.() ).postln;
}), \dur, 0.03, \amp, Pseq(~cresArrIn74_gliss1, 1), \ctranspose, Pseq(~transposeArrIn74_gliss1, 1));

~transposeArrIn74_gliss2 = (Array.series(7, -24, 9).round(0.00001)).reverse;
~glissIn74_2 = Pbind(\instrument, Prand(["playRandNotesSaw"], 7), \midinote, Pfunc({
	(~filterNote.() ).postln;
}), \dur, 0.08, \amp, 0.7, \ctranspose, Pseq(~transposeArrIn74_gliss2, 1));

~lowNotesIn74 = Pbind(\instrument, Prand(["playRandNotesSaw"], 300), \midinote, Pfunc({
	(~filterNote.() ).postln;
}), \dur, 0.005, \amp, 0.7, \ctranspose, -12);

~transposeTempIn74 = Array.fill(75, {rrand(-12, 24)});
~transposeArrIn74_randNotes = ((Array.series(75, -12, 0.5).round(0.0001)) + ~transposeTempIn74).reverse;
~decresArrIn74_randNotes = (Array.series(75, 0.02, 0.008 ).round(0.0001)).reverse;
~randRegNotesIn74 = Pbind(\instrument, Prand(["playRandNotesSaw"], 75), \midinote, Pfunc({
	(~filterNote.() ).postln;
}), \dur, 0.02, \amp, Pseq(~decresArrIn74_randNotes, 1), \ctranspose, Pseq(~transposeArrIn74_randNotes, 1));

~transposeArrIn74_gliss3 = (Array.series(50, -24, 2).round(0.00001));
~decresArrIn74_gliss3 = (Array.series(50, 0, 0.012).round(0.0001)).reverse;
~glissIn74_3 = Pbind(\instrument, Prand(["playRandNotesSine"], 50), \midinote, Pfunc({
	(~filterNote.() ).postln;
}), \dur, 0.01, \amp, Pseq(~decresArrIn74_gliss3, 1), \ctranspose, Pseq(~transposeArrIn74_gliss3, 1));
)

(
~routineIn74 = Routine {
	~notesIn74_1.play;
	0.5.yield;
	~notesIn74_2.play;
	0.5.yield;
	~glissIn74_1.play;
	0.1.yield;
	~glissIn74_2.play;
	0.9.yield;
	~lowNotesIn74.play;
	1.yield;
	~randRegNotesIn74.play;
	1.5.yield;
	~glissIn74_3.play;
	0.5.yield;
}.play;
)





//// 75
// sine long note for 2 seconds
~sineIn75_a = {SinOsc.ar(440, 1, 0.2)}.play;





//// 76
(
~notesIn76 = Pbind(\instrument, Prand(["playRandNotesSine"], 4), \midinote, Pfunc({
	(~filterNote.() ).postln;
}), \dur, 0.05, \amp, 0.5, \ctranspose, 12);

~notesIn76_2 = Pbind(\instrument, Prand(["playRandNotesSaw2"], 8), \midinote, Pfunc({
	(~filterNote.() ).postln;
}), \dur, 0.05, \amp, 0.5, \ctranspose, 12);
)

(
~routineIn76 = Routine {
	~notesIn76.play;
	3.yield;
	~notesIn76_2.play;
	1.yield;
}.play;
)





//// 77
(
~notesIn77 = Pbind(\instrument, Prand(["playRandNotesSine3"], 10), \midinote, Pfunc({
	(~filterNote.() ).postln;
}), \dur, 0.068, \amp, 0.5, \ctranspose, 12);
~notesIn77.play;
)






//// 78
(
~notesIn78_1 = Pbind(\instrument, Prand(["playRandNotesSine3"], 8), \midinote, Pfunc({
	(~filterNote.() ).postln;
}), \dur, 0.05, \amp, 0.5, \ctranspose, 12);

~notesIn78_2 = Pbind(\instrument, Prand(["playRandNotesSaw3"], 5), \midinote, Pfunc({
	(~filterNote.() ).postln;
}), \dur, 0.03, \amp, 0.5, \ctranspose, -12);

~cresArrIn78_temp = (Array.series(3, 0.1, 0.3)).round(0.001).reverse;
~cresArrIn78 = ~cresArrIn78_temp ++ (Array.series(7, 0.15, 0.1).round(0.0001));
~notesIn78_3 = Pbind(\instrument, Prand(["playRandNotesSine"], 10), \midinote, Pfunc({
	(~filterNote.() ).postln;
}), \dur, 0.05, \amp, Pseq(~cresArrIn78, 1), \ctranspose, 24);
)
(
~routineIn78 = Routine {
	~notesIn78_1.play;
	1.5.yield;
	~notesIn78_2.play;
	0.5.yield;
	~notesIn78_3.play;
	1.yield;
}.play;
)





//// 79
(
~notesIn79_1 = Pbind(\instrument, Prand(["playRandNotesSine"], 8), \midinote, Pfunc({
	(~filterNote.() ).postln;
}), \dur, 0.06, \amp, 0.5, \ctranspose, 12);

~notesIn79_2 = Pbind(\instrument, Prand(["playRandNotesSineCut2"], 4), \midinote, Pfunc({
	(~filterNote.() ).postln;
}), \dur, 0.1, \amp, 0.5, \ctranspose, 18);
)
(
~routineIn79 = Routine {
	~notesIn79_1.play;
	2.yield;
	~notesIn79_2.play;
}.play;
)





//// 80
(
~durArrIn80_temp = Array.series(4, 0.1, 0.1);
~durArrIn80 = ~durArrIn80_temp + [0.02, 0.08, 0.03, 0.04];
~notesIn80 = Pbind(\instrument, Prand(["playRandNotesSaw3"], 4), \midinote, Pfunc({
	(~filterNote.() ).postln;
}), \dur, Pseq(~durArrIn80, 1), \amp, 0.5, \ctranspose, 12);
~notesIn80.play;
)






//// 81
(
~transposeArrIn81_1 = Array.fill(500, {rrand(-24, -20)});
~notesIn81_1 = Pbind(\instrument, Prand(["playRandNotesSaw3"], 500), \midinote, Pfunc({
	(~filterNote.() ).postln;
}), \dur, 0.01, \amp, 0.4, \ctranspose, Pseq(~transposeArrIn81_1, 1));

~transposeArrIn81_temp = (Array.series(500, -7, 0.024)).round(0.001).reverse;
~transposeArrIn81_2 = ((Array.fill(500, {rrand(-24, -12)})) + ~transposeArrIn81_temp);

~cresIn81_temp = (Array.series(250, 0.1, 0.0015).round(0.001));
~decreIn81_temp = (Array.series(250, 0.1, 0.0015).round(0.001)).reverse;
~ampArrIn81 = ~cresIn81_temp ++ ~decreIn81_temp;
~notesIn81_2 = Pbind(\instrument, Prand(["playRandNotesSaw3"], 500), \midinote, Pfunc({
	(~filterNote.() ).postln;
}), \dur, 0.01, \amp, Pseq(~ampArrIn81, 1), \ctranspose, Pseq(~transposeArrIn81_2, 1));
)
(
~routineIn81 = Routine {
	~notesIn81_1.play;
	5.yield;
	~notesIn81_2.play;
}.play;
)





//// 82
(
~transposeArrIn82_temp = (Array.series(500, -7, 0.024)).round(0.001).reverse;
~transposeArrIn82 = ((Array.fill(500, {rrand(-24, -12)})) + ~transposeArrIn82_temp);

~decreIn82 = (Array.series(500, 0.1, 0.0008).round(0.001)).reverse;

~notesIn82= Pbind(\instrument, Prand(["playRandNotesSaw3"], 500), \midinote, Pfunc({
	(~filterNote.() ).postln;
}), \dur, 0.01, \amp, Pseq(~decreIn82, 1), \ctranspose, Pseq(~transposeArrIn82, 1));
~notesIn82.play;
)






//// 83
(
~transposeArrIn83_temp = (Array.series(600, 12, 0.024)).round(0.001);
~transposeArrIn83 = ((Array.fill(600, {rrand(-24, -12)})) + ~transposeArrIn83_temp);

~decreIn83 = (Array.series(600, 0.05, 0.0007).round(0.001)).reverse;

~durArrIn83_temp = Array.fill(400, 0.01);
~durArrIn83 = ~durArrIn83_temp ++ Array.series(200, 0.01, 0.005);

~notesIn83= Pbind(\instrument, Prand(["playRandNotesSaw3"], 500), \midinote, Pfunc({
	(~filterNote.() ).postln;
}), \dur, Pseq(~durArrIn83, 1), \amp, Pseq(~decreIn83, 1), \ctranspose, Pseq(~transposeArrIn83, 1));
~notesIn83.play;
)






//// 84, 85, 86/ ending parts
// control sound using slider while recording
//simple playbuf grain synthdef - note the all important doneAction
(
SynthDef(\sfgrain, {arg bufnum=0, pan=0.0, startPos=0.0, amp=0.1, dur=0.04;
var grain;
grain= PlayBuf.ar(1,bufnum, BufRateScale.kr(bufnum), 1, BufFrames.ir(bufnum)*startPos, 0)*(EnvGen.kr(Env.perc(0.01,dur),doneAction:2)-0.001);
Out.ar(0,Pan2.ar(grain, pan))}).add;
)

b = Buffer.read(s,"/Users/shuyulin/Desktop/trioForClsEle/electronics/scripts/1_mono.wav");

//overlaps eight windows of 0.1 seconds, so one window every 0.1/8 = 0.0125 seconds
{Warp1.ar(1,b,pointer:MouseX.kr,freqScale:(2**(MouseY.kr(-2,2))),windowSize:0.1)}.scope

///////////////////// END /////////////////////
