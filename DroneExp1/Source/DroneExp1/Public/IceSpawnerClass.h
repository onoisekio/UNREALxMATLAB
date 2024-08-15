// Fill out your copyright notice in the Description page of Project Settings.

#pragma once

#include <vector>
#include "CoreMinimal.h"
#include "GameFramework/Actor.h"
#include "IceSpawnerClass.generated.h"

UCLASS(Blueprintable, Config = Game, meta = (BlueprintSpawnableComponent))
class DRONEEXP1_API AIceSpawnerClass : public AActor
{
	GENERATED_BODY()
	
public:	
	//some standard values
	const float iceDensity = 0.9168;
	// Sets default values for this actor's properties
	AIceSpawnerClass();
	//spawn method
	UFUNCTION(BlueprintCallable, Category = IceSpawner)
		void Init();
	UFUNCTION(BlueprintCallable, Category = IceSpawner)
		void SpawnNextRegion();
	UFUNCTION(BlueprintCallable, Category = IceSpawner)
		void SpawnAllRegions();
	UFUNCTION(BlueprintCallable, Category = IceSpawner)
		void SpawnIcePiece(FVector pos, FVector size);
	UFUNCTION(BlueprintCallable, Category = IceSpawner)
		void ClearActiveIcePieces();
	//Get all the locations to place the ice
	std::vector<FVector> GetLocations();
	//Get the unit size of the ice to spawn
	float GetUnitSize(int index);
	// Called every frame
	virtual void Tick(float DeltaTime) override;
	//global vector for all the locations
	std::vector<FVector> locations;
	
	// Whether to get data from an XML file or not.
	// If using XML file, uses data from XMLFilePath, ActorToSpawn, n, dimension and thickness
	// If not using XML file, uses data from ActorToSpawn, VisualMesh, n, dimension and thickness
	UPROPERTY(EditDefaultsOnly)
		bool UseXML;
	// XML file path for ice objects
	UPROPERTY(EditDefaultsOnly)
		FString XMLFilePath;
	//reference to the actor being spawned,
	// should match VisualMesh
	UPROPERTY(EditDefaultsOnly)
		TArray<TSubclassOf<AActor>> ActorsToSpawn;
	// reference to the visualmesh of the actor,
	// should match ActorToSpawn
	UPROPERTY(EditDefaultsOnly)
		TArray<UStaticMesh*> VisualMeshes;
	// we end up with 2^n by 2^n number of ice structures,
	// set to -1 if you want to automatically set the number of ice structures
	UPROPERTY(EditDefaultsOnly)
		float n;
	// dimension of ice in cm
	UPROPERTY(EditDefaultsOnly)
		float dimension;
	// thickness of ice in cm
	UPROPERTY(EditDefaultsOnly)
		float thickness;

protected:
	// Called when the game starts or when spawned
	virtual void BeginPlay() override;

private:
	TArray<AActor*> ActiveIcePieces;

	TArray<TArray<TArray<FVector>>> IceRegions;

	int nextRegionIndex;
};
