// Fill out your copyright notice in the Description page of Project Settings.


#include "MySim3dActor.h"
// set default values
AMySim3dActor::AMySim3dActor():SignalReader(nullptr), SignalWriter(nullptr) {

}

void AMySim3dActor::Sim3dSetup()
{
    Super::Sim3dSetup();
    if (Tags.Num() != 0) {
        unsigned int numElements = 3;
        FString tagName = Tags.Top().ToString();

        FString SignalReaderTag = tagName;
        SignalReaderTag.Append(TEXT("Set"));
        SignalReader = StartSimulation3DMessageReader(TCHAR_TO_ANSI(*SignalReaderTag), sizeof(float) * numElements);

        FString SignalWriterTag = tagName;
        SignalWriterTag.Append(TEXT("Get"));
        SignalWriter = StartSimulation3DMessageWriter(TCHAR_TO_ANSI(*SignalWriterTag), sizeof(float) * numElements);
    }
}

void AMySim3dActor::Sim3dStep(float DeltaSeconds)
{
    UE_LOG(LogTemp, Warning, TEXT("Third message is %d"), 00000003);
    unsigned int numElements = 3;
    float array[3];
    int statusR = ReadSimulation3DMessage(SignalReader, sizeof(float) * numElements, array);
    FVector NewLocation;
    NewLocation.X = array[0];
    NewLocation.Y = array[1];
    NewLocation.Z = array[2];
    SetActorLocation(NewLocation);
    float fvector[3] = { NewLocation.X, NewLocation.Y, NewLocation.Z };
    int statusW = WriteSimulation3DMessage(SignalWriter, sizeof(float) * numElements, fvector);
}

void AMySim3dActor::Sim3dRelease()
{
    Super::Sim3dRelease();
    if (SignalReader) {
        StopSimulation3DMessageReader(SignalReader);
    }
    SignalReader = nullptr;

    if (SignalWriter) {
        StopSimulation3DMessageWriter(SignalWriter);
    }
    SignalWriter = nullptr;
}
