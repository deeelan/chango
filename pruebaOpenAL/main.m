//
//  main.m
//  Prueba OpenAL
//
//  Adapted by Gerardo M. Sarria M. on 2/03/11.
//

#import <Cocoa/Cocoa.h>
#include <stdlib.h>
//#include <conio.h>
#include <math.h>

#include <OpenAL/al.h>
#include <OpenAL/alc.h>
//#include <al/alut.c>



// Constants

#define NUM_BUFFERS 16
#define NUM_SOURCES 16

// Sounds assets

#define INTRO       0

// Escena 1

#define POP_MUSIC   1
#define PHONE_RING  2
#define ELI1        3   // Quihubo amiga
#define VAL1        4   // Hola Eli, ¿Como vas?
#define ELI2        5   // Bien... ¿Que haras el sábado?
#define VAL2        6   // Mmm... no mucho... ¿Por?
#define ELI3        7   // ¡Vamos a bailar! ¡Es el cumple de Marcos! ¿Te apuntas?
#define VAL3        8   // Mmmm...no se... tal vez...
#define VAL4_1      9   // No amix, tu sabes que Marcos es como raro conmigo... no me sentiría bien
#define PHONE_TONE  10
#define VAL4_1_1    11  // Val, yo voy
#define VAL4_2      12  // Vale amiga... ¡Tengo ganas de bailar!... Además quien quita... ¡A lo mejor hablo con Marcos!
#define ELI4_2_1    13  // ¡Eso amiga! ¡Que por eso mismo te ando invitando!
#define VAL4_2_1    14  // Vale Eli, nos vemos el sábado
#define ELI4_2_2    15  // Vale, ¡mua!

//

// Buffers hold sound data.
ALuint Buffers[NUM_BUFFERS];

// Sources are points of emitting sound.
ALuint Sources[NUM_SOURCES];

// Position of the source sounds.
ALfloat SourcesPos[NUM_SOURCES][3];

// Velocity of the source sounds.
ALfloat SourcesVel[NUM_SOURCES][3];



// Position of the listener.
ALfloat ListenerPos[] = { 0.0, 0.0, 0.0 };

// Velocity of the listener.
ALfloat ListenerVel[] = { 0.0, 0.0, 0.0 };

// Orientation of the listener. (first 3 elements are "at", second 3 are "up")
ALfloat ListenerOri[] = { 0.0, 0.0, -1.0, 0.0, 1.0, 0.0 };


/*
 * ALboolean LoadALData()
 *
 *    This function will load our sample data from the disk using the alut
 *    utility and send the data into OpenAL as a buffer. A source is then
 *    also created to play that buffer.
 */
ALboolean LoadALData()
{
    // Variables to load into.
    
    ALenum format;
    ALsizei size;
    ALvoid* data;
    ALsizei freq;
    ALboolean loop;
    
    // Load wav data into buffers.
    
    alGenBuffers(NUM_BUFFERS, Buffers);
    if(alGetError() != AL_NO_ERROR)
        return AL_FALSE;
    
    alutLoadWAVFile("/Users/veevart/Documents/chango/pruebaOpenAL/src/escena1/7-rings.wav", &format, &data, &size, &freq, &loop);
    alBufferData(Buffers[POP_MUSIC], format, data, size, freq);
    alutUnloadWAV(format, data, size, freq);
    
//    SourcesPos[POP_MUSIC][0] = 0.0f;
//    SourcesPos[POP_MUSIC][1] = 0.0f;
//    SourcesPos[POP_MUSIC][2] = 0.0f;
    
    alutLoadWAVFile("/Users/veevart/Documents/chango/pruebaOpenAL/src/escena1/Menu.wav", &format, &data, &size, &freq, &loop);
    alBufferData(Buffers[INTRO], format, data, size, freq);
    alutUnloadWAV(format, data, size, freq);
    
    // Bind buffers into audio sources.
    
    alGenSources(NUM_SOURCES, Sources);
    
    if(alGetError() != AL_NO_ERROR)
        return AL_FALSE;
    
    alSourcei (Sources[POP_MUSIC], AL_BUFFER,   Buffers[POP_MUSIC]  );
    alSourcef (Sources[POP_MUSIC], AL_PITCH,    0.9f               );
    alSourcef (Sources[POP_MUSIC], AL_GAIN,     0.01f                );
    alSourcefv(Sources[POP_MUSIC], AL_POSITION, SourcesPos[POP_MUSIC]);
    alSourcefv(Sources[POP_MUSIC], AL_VELOCITY, SourcesVel[POP_MUSIC]);
    alSourcei (Sources[POP_MUSIC], AL_LOOPING,  AL_FALSE           );
    
    alSourcei (Sources[INTRO], AL_BUFFER,   Buffers[INTRO]  );
    alSourcef (Sources[INTRO], AL_PITCH,    1.0f               );
    alSourcef (Sources[INTRO], AL_GAIN,     1.0f                );
    alSourcefv(Sources[INTRO], AL_POSITION, SourcesPos[INTRO]);
    alSourcefv(Sources[INTRO], AL_VELOCITY, SourcesVel[INTRO]);
    alSourcei (Sources[INTRO], AL_LOOPING,  AL_FALSE           );
    
    // Do another error check and return.
    
    if(alGetError() != AL_NO_ERROR)
        return AL_FALSE;
    
    return AL_TRUE;
}



/*
 * void SetListenerValues()
 *
 *    We already defined certain values for the listener, but we need
 *    to tell OpenAL to use that data. This function does just that.
 */
void SetListenerValues()
{
    alListenerfv(AL_POSITION,    ListenerPos);
    alListenerfv(AL_VELOCITY,    ListenerVel);
    alListenerfv(AL_ORIENTATION, ListenerOri);
}



/*
 * void KillALData()
 *
 *    We have allocated memory for our buffers and sources which needs
 *    to be returned to the system. This function frees that memory.
 */
void KillALData()
{
    alDeleteBuffers(NUM_BUFFERS, Buffers);
    alDeleteSources(NUM_SOURCES, Sources);
    alutExit();
}

int escenaUno()
{
    alSourcePlay(Sources[INTRO]);
    
    printf("\n ▄▀▄▄▄▄   ▄▀▀▄ ▄▄   ▄▀▀█▄   ▄▀▀▄ ▀▄  ▄▀▀▀▀▄    ▄▀▀▀▀▄  \n█ █    ▌ █  █   ▄▀ ▐ ▄▀ ▀▄ █  █ █ █ █         █      █ \n▐ █      ▐  █▄▄▄█    █▄▄▄█ ▐  █  ▀█ █    ▀▄▄  █      █ \n  █         █   █   ▄▀   █   █   █  █     █ █ ▀▄    ▄▀ \n ▄▀▄▄▄▄▀   ▄▀  ▄▀  █   ▄▀  ▄▀   █   ▐▀▄▄▄▄▀ ▐   ▀▀▀▀   \n█     ▐   █   █    ▐   ▐   █    ▐   ▐                  \n▐         ▐   ▐            ▐                           ");
    
    // Go through all the sources and check that they are playing.
    // Skip the first source because it is looping anyway (will always be playing).
    
    ALint state;
    
    printf("\n\n\n\t\t\t\tPress ENTER to begin");
    getchar();
    
    float t = 10.0f;
    float d = 0.1f;
    while(t > 0)
    {
        alSourcef(Sources[INTRO], AL_GAIN, (t / 10.0f));
        t -= d;
        printf("\n");
        [NSThread sleepForTimeInterval:0.01f];
    }
    alSourceStop(Sources[INTRO]);
    
    [NSThread sleepForTimeInterval:2.5f];
    
    alSourcePlay(Sources[POP_MUSIC]);
    
    while(1)//!kbhit())
    {
        
        double theta = (double) (rand() % 360) * 3.14 / 180.0;

        SourcesPos[POP_MUSIC][0] = -(float)(cos(theta));
        SourcesPos[POP_MUSIC][1] = -(float)(rand()%2);
        SourcesPos[POP_MUSIC][2] = -(float)(sin(theta));
        
        NSLog(@"%@", @(SourcesPos[POP_MUSIC][0]).stringValue);
        NSLog(@"%@", @(SourcesPos[POP_MUSIC][1]).stringValue);
        NSLog(@"%@", @(SourcesPos[POP_MUSIC][2]).stringValue);
        
        alSourcefv(Sources[POP_MUSIC], AL_POSITION, SourcesPos[POP_MUSIC]);

        //alSourcePlay(Sources[POP_MUSIC]);

        //        for(int i = 1; i < NUM_SOURCES; i++)
        //        {
        //            alGetSourcei(Sources[i], AL_SOURCE_STATE, &state);
        //
        //            if(state != AL_PLAYING)
        //            {
        //                // Pick a random position around the listener to play the source.
        //
        //                double theta = (double) (rand() % 360) * 3.14 / 180.0;
        //
        //                SourcesPos[i][0] = -(float)(cos(theta));
        //                SourcesPos[i][1] = -(float)(rand()%2);
        //                SourcesPos[i][2] = -(float)(sin(theta));
        //
        //                alSourcefv(Sources[i], AL_POSITION, SourcesPos[i]);
        //
        //                alSourcePlay(Sources[i]);
        //            }
        //        }
    }
    
    return 1;
}

int main(int argc, char *argv[])
{
    // Initialize OpenAL and clear the error bit.
    
    alutInit(NULL, 0);
    alGetError();
    
    // Load the wav data.
    
    if(LoadALData() == AL_FALSE) {
        return 0;
    }
    
    SetListenerValues();
    
    // Setup an exit procedure.
    
    atexit(KillALData);
    
    escenaUno();
    
    return 0;
}
