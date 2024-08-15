// Fill out your copyright notice in the Description page of Project Settings.

#pragma once

#include "CoreMinimal.h"
#include "GameFramework/Actor.h"
#include "BuoyancyPlacement.generated.h"

UCLASS()
class DRONEEXP1_API ABuoyancyPlacement : public AActor
{
	GENERATED_BODY()
	
public:	
	// Sets default values for this actor's properties
	UPROPERTY(EditAnywhere, BlueprintReadWrite, Category="Socket")
		int32 SocketCount;
	UPROPERTY(VisibleAnywhere)
		UStaticMeshComponent* VisualMesh;
	UFUNCTION(BlueprintCallable, Category = "Socket")
		void ReturnPoints(FName PontoonCenterSocket, FVector PontoonRelativeLocation, float PontoonRadius);
	ABuoyancyPlacement();

protected:
	// Called when the game starts or when spawned
	virtual void BeginPlay() override;
	bool meshAttached;

public:	
	// Called every frame
	virtual void Tick(float DeltaTime) override;
};
