// Fill out your copyright notice in the Description page of Project Settings.

#pragma once

#include "CoreMinimal.h"
#include "BuoyancyComponent.h"
#include "MyBuoyancyComponent1.generated.h"

/**
 * 
 */
UCLASS()
class DRONEEXP1_API UMyBuoyancyComponent1 : public UBuoyancyComponent
{
	GENERATED_BODY()
	
	UFUNCTION(BlueprintCallable, Category = "Buoyancy")
	void AddPontoon(FName PontoonCenterSocket, FVector PontoonRelativeLocation, float PontoonRadius) {
		FSphericalPontoon pontoon = FSphericalPontoon();
		pontoon.CenterSocket = PontoonCenterSocket;
		pontoon.RelativeLocation = PontoonRelativeLocation;
		pontoon.Radius = PontoonRadius;
		BuoyancyData.Pontoons.Add(pontoon);
	}
};
