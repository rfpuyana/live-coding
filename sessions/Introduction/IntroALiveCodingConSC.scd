// INTRODUCCIÓN AL LIVE CODING CON SUPERCOLLIDER
//Abril 3 al 6 de 2018
//Bogotá, Colombia
//Plataforma
//Idartes
//impartido por Alexandra Cárdenas



/////////////////////////////////////////////PARTE 1
//para correr (evaluar o compilar) una línea de código, pon tu cursor en algún lugar de la línea y dale shift + return

"algo".postln;

"algo".postln;


(
"hello world".postln;
"Perro".postln
)

(
"hello world".postln;
"Perro".postln
)
/*   acá todo queda comentado  */


//"hello world" es una frase comunmente usada por programadores para hacer sus primeros intentos con un programa. Puede ser cualquier información la que le des a SuperCollider. El mensaje .postln le indica a SuperCollider qué hacer con esa información. En este caso, le dice que la imprima en la Post Window.

//La Post Window te dice toda la información necesaria sobre qué está sucediendo con SC. Con cmd + p la seleccionas. Tambien la encuentras en el menú "View".

//Cambia el string de información para familiarizarte con la Post Window

//todo después de // es un comentario. Es útil para los humanos, para recordar cosas. SuperCollider ignora el texto. También puedes usar /* */

s.boot //SuperCollider está dividido en el intérprete y el servidor. s es la variable para el servidor. Para iniciar el servidor le enviamos el mensaje .boot. También puedes darle cmd+b o en el menu Server > boot
s.quit;

s.boot

//////////////////////// Live Coding con Super Collider! opción 1. Jit Lib
////Julian Rohruhber , Alemania

p = ProxySpace.push; // abrir un proxy space y enviarlo al servidor


().play // este código toca el sonido por defecto de SuperCollider

//Cuando queremos hacer sonidos, normalmente mandamos el método .play

//Es importante darle nombres a nuestros sonidos para poder manejarlos mejor. Usamos entonces variables globales en este caso. Por ejemplo:

~alicia= { }
~alicia.play
//todo lo que haya adentro de los corchetes se llama alicia ahora.

// démosle más información a alicia

//UGens

~alicia ={ SinOsc.ar(880)}

~alicia.play

~alicia.stop


~alicia ={ SinOsc.ar(MouseX.kr(440, 880), mul:MouseY.kr(0,1))}
~alicia.play
~alicia.stop

~alicia ={ SinOsc.ar([MouseX.kr(440, 1000), MouseY.kr(1000, 440)])}
~alicia.play
~alicia.stop


//podemos automatizar con los datos del Mouse
[MouseY.kr(200, 800), MouseX.kr(1200, 500)]

// !2 factorización!

~alicia.play //play
~alicia.stop //stop
~alicia.clear //quitar del servidor

s.makeWindow


// SinOsc es una onda Sinusoidal. Hay varias ondas que podemos usar con SC

~amelia = { Saw.ar };
~amelia.play
~amelia.stop

~anne = { PinkNoise.ar };
~anne.play;
~anne.stop;

~afrodita = { Pulse.ar };
~afrodita.play;
~afrodita.stop;

~amelia.play;~anne.play;~afrodita.play;

~amelia.stop;~anne.stop;~afrodita.stop;


//podemos ver la forma de onda con scope
s.scope(4)

//hasta ahora sólo le hemos dicho a SC qué tipo de onda queremos escuchar, pero no valores de frecuencia o volumen, por lo que SC usa los valores que tiene programados por defecto.

//para añadir nuestros propios valores, necesitamos escribirlo en los argumentos de cada UGen

~alicia = { SinOsc.ar(400, mul: 0.7 )  }; ~alicia.play

//cambia los valores para escuchar cómo cambia el sonido
//mul es la variable usada en SuperCollider para la amplitud o volumen.

~alicia = { SinOsc.ar([1300, 100])  };
~alicia.play
~alicia.stop

~andrea= {VarSaw.ar([1590, 340])}; ~andrea.play
~andrea.stop


// FELICIDADES! YA ESTÁS LIVE CODEANDO!

//Por ahora el sonido está cambiando en cuanto compilas el código, pero musicalmente es importante también poder hacer cross fades entre estados diferentes del audio:

p.fadeTime =10;
// esto hará que la nueva versión de tus sonidos tomen diez segundos en aparecer, mientras la antigua versión toma 10 segundos en desaparecer.

// también podemos darle un fade time a cada sonido individualmente.

~alicia.fadeTime = 5;

~andrea.fadeTime = 20;


// Los argumentos pueden escribirse sin nombres:

~alicia = { SinOsc.ar(600, 0, 0.2) }; ~alicia.play

//Para ver los argumentos de cada UGen, invoca la ayuda de SC seleccionando el objeto y dándole cmd + d

// o si comienzas a escribir los argumentos, una cajita de ayuda debe salir en cuanto escribes el primer paréntesis.
//intenta añadir argumentos a los siguientes sonidos

~andrea = { Saw.ar }; ~andrea.stop
~ana = { PinkNoise.ar}; ~ana.play


// Ahora que tenemos varios sonidos corriendo, tal vez te sea útil esta pequeña mezcladora:

ProxyMixer.new(p); // automáticamente muestra tus sonidos

ProxyMixer(p); //muestra el mixer

// esto te da una forma gráfica de mezclar sonidos.

// si ponemos un nuevo sonido, aparecerá en el mixer

~beatriz = { Impulse.ar(freq: 5) }

s.meter //muestra un metro gráfico de amplitud y canales

// si queremos tocar más de una frecuencia a la vez, podemos usar paréntesis cuadrados, que significa que lo que hay adentro es un Array, o una lista de cosas.
p.fadeTime = 0

~masumi = {Splay.ar((SinOsc.ar ([234,  700, 345, 456, 567, 678, 1200, 2000])))}
~masumi.play
~masumi.stop

~carolina = { Saw.ar([700, 800, 900, 600], 0.1) }; ~andrea.stop

~betty = { Saw.ar([700, 1800], 0.1) }; ~betty.stop

//el primer sonido que compilamos después de abir el proxy space, define la cantidad de canales de audio con la que podremos trabajar.
//Normalmente [123, 234] significa que SC tocará la primera en el canal 0 y la segunda en el 1.
// así que si añadimos más frecuencias, se seguirán añadiendo al primer canal.
// si queremos hacer un sonido que tenga muchas frecuencias al tiempo, podemos usar Mix.new para indicarle a SC que queremos escuchar todas las frecuencias en un sólo canal.
//También podemos usar Splay.ar

///Mix.new (todo en un canal)
~boudica = { Mix.new( SinOsc.ar([50, 75, 100].midicps) ) }
~boudica.stop

//7 canales separados, para los que necesitaríamos una interfaz de audio con 7 canales
~boudica1 = { SinOsc.ar([200, 400, 1234, 288, 359, 1000.01, 4000]) }
~boudica1.play
~boudica1.stop

/////////Splay mezcla el array en 2 canales (stéreo)
~boudica2 = { SinOsc.ar([500, 200, 400, 450]) }

~boudica2 = { Splay.ar(SinOsc.ar([500, 200, 400, 450, 1000, 2000]) ) }
~boudica2.play
~boudica2.stop
~boudica2.clear


//////////////////////////////////////////////////////////////////////PART 2

////ONDAS SINUSOIDALES!
~boudica_2 = { Splay.ar( SinOscFB.ar(Array.fill(10, { rrand(50, 8000) } )).distort }
~boudica_2.stop

~boudica_2.fadeTime = 5

~boudica_3 = { Splay.ar( VarSaw.ar(Array.fill(6, { rrand(100, 1300) } )) ) }
~boudica_3.play
~boudica_3.stop


~andrea= { Splay.ar( LFPulse.ar(Array.fill(6, { rrand(80, 1000) } )) ) }
~andrea.stop

ProxyMixer.new(p); // mixer gráfico automático
p.fadeTime = 1;

s.scope
s.makeWindow //nos muestra la ventana del servidor

//también hay formas automáticas de llenar arrays de forma aleatoria:

Array.fill(5, { rrand(50, 5000) } )

// Esto se llama síntesis aditiva!


// Otra forma de síntesis es la síntesis substractiva!

~filter_betty = { BPF.ar(Saw.ar([300, 800], 0.1), 500, 0.6)  } //Band pass filter
~filter_betty.play
~filter_betty.stop

~filter_betty = { BPF.ar(Saw.ar([300, 800], 0.1), MouseY.kr(200, 1700), MouseX.kr(0.01, 1))  } //Band pass filter con automatización del mouse
~filter_betty.play
~filter_betty.stop


///Filtro pasa bajos, Low pass filter LPF

~marco = { LPF.ar(Splay.ar( LFPulse.ar(Array.fill(6, { rrand(80, 2000) } )) ), 500) }
~marco.play
~marco.stop

///Filtro pasa altos, High pass filter HPF

~marco = { HPF.ar(Splay.ar( LFPulse.ar(Array.fill(6, { rrand(80, 2000) } )) ), 900) }
~marco.play
~marco.stop


///Filtro pasa bandas, Band pass filter HPF

~marco = { BPF.ar(Splay.ar( LFPulse.ar(Array.fill(6, { rrand(80, 2000) } )) ), 1900, 0.1)}

	~marco.play
~marco.stop



//RLPF es un tipo diferente de low pass filter. La ayuda de SC te muestra ejemplos y Ugens relacionados.

~filter_betty = { RLPF.ar(Saw.ar([700, 800], 0.1), 800, 0.2, 1)  }

~filter_betty = { RHPF.ar(~betty.ar, 800, 0.2, 1)  }
// otro ejemplo con high pass filter

// ver cómo podemos anidar las variables!


//Un tercer tipo de síntesis, que es útil para hacer sonidos más complejos, se llama Modulación. Esto significa que usamos una segunda forma de onda para modular la primera. El modo más simple de hacer esto es la Amplitud Modulada:

//acá podemos ver claramente la diferencia entre audio rate y control rate (ar y kr)

~catherine = { Pulse.ar([158, 260], mul: SinOsc.kr(5, 0, 0.7, 15))}

~catherine.play
~catherine.stop


~catherine = { Pulse.ar([100, 120], 0.5, 1)  }
//la frecuencia de SinOsc nos marca qué tan rápido la amplitud cambia y el mul y el add cuánto cambia.


~catherine = { VarSaw.ar([100, 120], 0.5, mul:SinOsc.kr(6).range(0, 1))  }

~catherine.stop
//algunas veces es más fácil especificar la cantidad de modulación con el método range. Acá especificamos el límite superior y el inferior de la modulación de amplitud.

// y también puedes usar otras formas de onda para modular la amplitud:

~catherine = { Pulse.ar([100, 120], 0.9, Saw.kr(1).range(0, 1))  }
~catherine = { Pulse.ar([100, 120], 0.5, LFNoise1.kr(100).range(0, 1))  }

~catherine.stop


//otro tipo de modulación es la Frecuencia Modulada. Acá multiplicamos una frecuencia base con otro tipo de onda.

~cleopatra = { SinOsc.ar([200, 310] * SinOsc.kr(8, 0, 2), 0, 1 ) }
//trata con diferentes valores para freq y mul en el modulador

~cleopatra.play
~cleopatra.stop


~cleopatra = { SinOsc.ar([300, 350] * ~catherine.kr, 0, 1 ) }
//también podemos usar otros sonidos como moduladores

//////EFECTOS
///podemos añadir reverberaciones, delays y otros efectos a nuestros sonidos

~giselle = { FreeVerb.ar (SinOsc.ar([200, 310] * SinOsc.kr(2, 0, 4), 0, 1 ) , 0.8, 1)}
~giselle.play
~giselle.stop


SinOsc.ar([200, 310] * SinOsc.kr(8, 0, 2), 0, 1 )
~daphne = { GVerb.ar(~cleopatra.ar, 10, 0.1) } //puedes encontrar los argumentos en el archivo de ayuda. Cuidado con valores muy altos pues pueden crashear SC.

~delia = { CombC.ar(~catherine.ar, 1, 0.05)  }

~dolores = { Decimator.ar(~alice.ar, 44100 * 1, 2) }

~dorothy = { DFM1.ar(BPF.ar(~anne.ar, 600, 0.3), 600, 0.99) }


LeakDC.ar

// combina lo que has aprendido para hacer sonidos más interesantes!

~laurie = { (SinOsc.ar([440, 442] + 1000 * LFSaw.kr(10).range(1, 0.9), 0, LFSaw.kr(15).range(1, 0)) * LFSaw.kr(1).range(SinOsc.ar(0.1).range(1, 6), 0) ).tanh}

~filter_laurie = {  (CombC.ar(~laurie.ar, 1, LFNoise0.kr(20).range(0.01, 0.1).round(0.01)) * LFSaw.kr(0.3).range(0, 2)).tanh }

~filter_laurie_2 = { GVerb.ar(DFM1.ar(~filter_laurie.ar, 500, 0.99), 10, 4) * 2 }


PdefAllGui.new

///////////////SYNTHDEFS
///Un SynthDef es una estructura básica de SC. Es una receta que se guarda en la memoria del programa. Podemos usar esta receta una y otra vez para hacer sonidos similares. Podemos hacer uso de las variables, tanto internamente como externamente a la estructura.
//Mira cómo podemos agrupar toda la estructura con paréntesis.
//analizar el uso de variables

(
SynthDef(\sp, { |out=0, amp=0.1, attack=0.01, release=0.1, freq=400|
	var snd, env;
	       snd = SinOsc.ar(freq);
	              env = EnvGen.ar(Env.perc(attack, release), doneAction:2);
	Out.ar(out, snd * env * amp);
}).add;
)

(
SynthDef(\sw, { |out=0, amp=0.1, attack = 0.1, release=0.1, freq1=440, freq2=345, corte = 500|
	var snd, env, filt;
	      snd = VarSaw.ar([freq1, freq2]);
	          filt = LPF.ar(snd, corte);
               env = EnvGen.ar(Env.perc(attack, release), doneAction:2);
	Out.ar(out, filt * env * amp);
}).add;
)

x = Synth(\sw);
// así disparamos el SynthDef

x = Synth(\sn, [\attack, Array.fill(1, {rrand(0.1, 3)}), \release, Array.fill(1, {rrand(0.1, 3)}), \freq, Array.fill(1, {rrand(100, 1000)}), \amp, 0.15]);
//así hacemos cambios al SynthDef al momento de dispararlo

y = Synth(\sw);

y = Synth(\sw, [\attack, 1, \release, 1, \freq1, Array.fill(1, {rrand(100, 3000)}), \freq2, Array.fill(1, {rrand(100, 3000)}), \amp, 0.25, \corte, 600]);


/////Segunda opción para live coding en SC
////PATTERNS Pdef

/////Los patrones son estructuras basadas en loops de información con las que podremos secuenciar y modificar los sonidos de los SynthDefs

//este es el Pdef por defecto
(
Pdef(\pattern_1,
	Pbind(
		\instrument, \sn,
		\amp, 0.5,
		\dur, Prand([1, 0.5, 0.25], inf),
		\degree, Prand([[3, 4], 1, [5, 8], [3, 8, 10], [1, 4, 7, 9]], inf),
		\attack, Prand([0.1, 0.5, 1], inf),
		\release, Prand([0.1, 0.4, 2], inf),
		\out, 1,
))
);

Pdef(\pattern_1).stop
Pdef(\pattern_1).play
Pdef(\pattern_1).fadeTime= 5

///otra versión
(
Pdef(\pattern_2,
	Pbind(
		\instrument, \sw,
		\amp, 0.2,
		\dur, 1,
		\attack, 0.1,
		\release, 10,
		\freq, 1385,
		\out, 0,
))
);

Pdef(\pattern_2).stop
Pdef(\pattern_2).play

//los patrones nos permiten usar listas de números para especificar parámetros. Pseq toca la lista en orden las veces que le indiquemos. Si le decimos inf, repetirá el patrón para siempre.

// podemos tocar escalas
(
Pdef(\pattern_2,
	Pbind(
		\amp, Pseq([1, 0.5, 0.2], inf),
		\instrument, \sn,
		\dur, Pseq([0.5, 0.5, 1], inf),
		\scale, Scale.lydian,
		\degree, Prand([0, 5, 3, 7, 9, 12], inf),
		\out, 0,
))
);

Pdef(\pattern_2).play
Pdef(\pattern_2).stop



Pdef(\pattern_2,
	Pbind(
		\amp, 1,
		\instrument, \sn,
		\dur, 0.5,
		\degree, Prand([0, 1, 2, 3, 4, 5, 6, 7], 3), // Prand elejirá los elementos de la lista de forma aleatoria
		\out, 0,
	)
);

Pdef(\pattern_2).play

///////exploremos Pwhite

(
Pdef(\pattern_3,
	Pbind(
		\amp, Pwhite(0.0, 1.0).trace,
		\instrument, \sn,
		\dur, Pwhite (0.1, 0.5).trace,
		\degree, Pwhite(0, 7).trace, // Pwhite elije entre un rango de números
		\out, 0,
))
);

Pdef(\pattern_3).play
Pdef(\pattern_3).stop

//haz tu propio patrón con Pseq, Prand y Pwhite para amplitud y duración.

////NGeneradores de Ruido
(
SynthDef(\noise, { | width= 1, cut= 440, out=0, attack=0.01, release=0.1, vol=0.5|
	var snd, env, pan;

	snd = BPF.ar(BrownNoise.ar, cut, width);
	//snd = BrownNoise.ar(MouseY.kr(0, 1));

	pan = Pan2.ar(snd, LFDNoise3.kr(10).range(-1, 1));
	//pan = Pan2.ar(snd, LFDNoise3.kr(0.2).range(-1, 1));

	env = EnvGen.ar(Env.perc(attack, release), doneAction:2);
	OffsetOut.ar(out, pan * env);
}).add;
)

x = Synth(\noise);
x = Synth(\noise, [\attack, 5, \release, 10, \vol, 0.9, \cut, 3500, \width, 0.1]);



SynthDef(\generator, { |out=0,amp=0.1, release=0.1,freq1=440, freq2=345|
	var snd, env;

	snd = WhiteNoise.ar(0.6);

	env = EnvGen.ar(Env.perc(0.01, release), doneAction:2);
	OffsetOut.ar(out, snd * env * amp);
}).add;

)


//más ejemplos de SynthDefs
(
SynthDef(\dr, { |out=0,amp=0.1,sustain=0.01,freq=440, noise = 0.1, line=0.1|
	var snd, env, ctrl;
	//ctrl = ;
	snd = SinOsc.ar([freq, freq + 10] * XLine.kr(1, 0.001, line), 0.5pi, 3).tanh;
	snd = snd + BrownNoise.ar(noise * XLine.kr(1, 0.001, 0.05));
	snd = BPF.ar(snd, freq + 50, 0.9);
	snd = LeakDC.ar(snd);
	env = EnvGen.ar(Env.perc(0.01,sustain),doneAction:2);
	OffsetOut.ar(out, snd * env * amp);
}).add;
)


SynthDef(\nz, { |out=0,amp=0.1,sustain=0.01,freq=440, noise = 0.1, q = 0.5|
	var snd, env, ctrl;

	//ctrl = ;
	snd = (PinkNoise.ar(noise)).tanh;
	snd = BPF.ar(snd, freq, q);
	env = EnvGen.ar(Env.perc(0.01,sustain),doneAction:2);
	OffsetOut.ar(out, snd * env * amp);
}).add;


Pdef(\drum_pattern_1, // basic bass drum
	Pbind(
		\amp, 4,
		\instrument, \dr,
		\dur, 0.5,
		\freq, Pwhite(80, 120),
		\out, 0,
	)
);

Pdef(\drum_pattern_1).play

Pdef(\drum_pattern_2, //hi tom
	Pseq([
		Pbind(
			\amp, 4,
			\instrument, \dr,
			\dur, 0.5,
			\freq, Pwhite(80, 120, 4),
			\out, 0,
		),
		Pbind(
			\amp, Pseq([0, 2], inf),
			\instrument, \dr,
			\dur, 0.5,
			\legato, 0.1,
			//\noise, 0.9,
			\freq, Pwhite(680, 720, 4),
			//\line, 0.07,
			\out, 0,
		)
	], 2)
);

Pseq([Pdef(\drum_pattern_2), Pdef(\pattern_3)], inf).play

Pdef(\drum_pattern_2).stop

s.record
s.stopRecording

Pdef(\noise_pattern_1, //snare
	Pbind(
		\amp, Pseq([3, 5, 4, 4, 2], inf),
		\instrument, \nz,
		\dur, Pseq([0.125, 0.25, 0.25, 0.25, 0.125], inf),
		\legato, 0.1,
		\noise, 4,
		\q, 0.99,
		\freq, Pwhite(1280, 1220),
		\out, Pseq([0, 6, 8], inf),// [0,6,8]
	)
);

Pdef(\noise_pattern_1).play

PdefAllGui.new

// adding effects

Ndef(\a, { Out.ar(0, GVerb.ar(InFeedback.ar(6), 10, 0.1 )  )  });
Ndef(\a).stop

Ndef(\b, { Out.ar(0, CombC.ar(InFeedback.ar(8), 1, 0.1 )  )  });
Ndef(\b).stop

// mic input

~in = { SoundIn.ar(0).scope }
~in.clear

// scheduling

t = Task{

	{

		~laurie.play;

		4.wait;

		~laurie.stop;

		4.wait;

	}.loop

}

t.stop;

// recording

s.makeWindow



