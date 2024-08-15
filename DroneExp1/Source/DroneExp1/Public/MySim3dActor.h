// Fill out your copyright notice in the Description page of Project Settings.

#pragma once

#include "CoreMinimal.h"
#include "Sim3dActor.h"
#include "MySim3dActor.generated.h"

/**
 * 
 */
UCLASS()
class DRONEEXP1_API AMySim3dActor : public ASim3dActor
{
	GENERATED_BODY()
	void* SignalReader;
	void* SignalWriter;

public:
	// Sets default values for this actor's properties
	AMySim3dActor();

	virtual void Sim3dSetup() override;
	virtual void Sim3dRelease() override;
	virtual void Sim3dStep(float DeltaSeconds) override;
	
};
