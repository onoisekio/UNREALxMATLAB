// Fill out your copyright notice in the Description page of Project Settings.

#pragma once

#include "CoreMinimal.h"
#include "BuoyancyComponent.h"
#include "MyBuoyancyComponent.generated.h"


UCLASS(Blueprintable, Config = Game, meta = (BlueprintSpawnableComponent))
class DRONEEXP1_API UMyBuoyancyComponent : public UBuoyancyComponent
{
	GENERATED_BODY()

public:
	UFUNCTION(BlueprintCallable, Category = Buoyancy)
		int32 AddPontoons(UStaticMeshComponent* VisualMesh);

	UFUNCTION(BlueprintCallable, Category = Buoyancy)
		int32 AddPontoon(FVector RelativeLocation, float Radius);

	UFUNCTION(BlueprintCallable, Category = Buoyancy)
		void PresetBuoyancy(UStaticMeshComponent* VisualMesh);

	UFUNCTION(BlueprintCallable, Category = Buoyancy)
		void PresetPhysics(UStaticMeshComponent* VisualMesh);

	//standard general values
	const float stdXSize = 100;
	const float stdYSize = 100;
	const float stdZSize = 100;

	//standard physics values
	const float stdMass = 100;
	const float stdADamp = 0.01;
	const float stdLDamp = 0.01;

	//standard buoyancy values
	const float stdBCoeff = 0.1;
	const float stdBDamp = 1000;
	const float stdBDamp2 = 1;
	const float stdBRampMinV = 20;
	const float stdBRampMaxV = 50;
	const float stdBRampMax = 1;
	const float stdMaxBForce = 5000000;
	const float stdWaterShorePushFactor = 0.3;
	const float stdWaterVelocityStrength = 0.01;
	const float stdMaxWaterForce = 10000;
	
};