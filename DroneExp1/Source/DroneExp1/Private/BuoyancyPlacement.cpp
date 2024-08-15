// Fill out your copyright notice in the Description page of Project Settings.


#include "BuoyancyPlacement.h"
#include <string>
#include <string.h>
#include "BuoyancyComponent.h"

// Sets default values
ABuoyancyPlacement::ABuoyancyPlacement()
{
 	// Set this actor to call Tick() every frame.  You can turn this off to improve performance if you don't need it.
	PrimaryActorTick.bCanEverTick = true;

	SocketCount = 4;

	VisualMesh = CreateDefaultSubobject<UStaticMeshComponent>(TEXT("Mesh"));
	RootComponent = VisualMesh;
	//VisualMesh->SetupAttachment(RootComponent);

	//UBuoyancyComponent BuoyancyComp = FObjectInitializer();
	CreateDefaultSubobject<UBuoyancyComponent>(TEXT("Buoyancy"));
}

// Called when the game starts or when spawned
void ABuoyancyPlacement::BeginPlay()
{
	Super::BeginPlay();
	
	meshAttached = VisualMesh->GetStaticMesh() != NULL;

	UE_LOG(LogTemp, Warning, TEXT("%s"), (meshAttached ? TEXT("Static Mesh attached") : TEXT("Static Mesh not attached")));

	if (meshAttached) {
		//setting simulate physics to true
		VisualMesh->SetSimulatePhysics(true);

		//printing bound information
		UE_LOG(LogTemp, Display, TEXT("Static Mesh Bounds: %s"), *VisualMesh->GetStaticMesh()->GetBounds().ToString());
		UE_LOG(LogTemp, Display, TEXT("Static Mesh Bounds: %s"), *VisualMesh->GetStaticMesh()->GetBounds().ToString());
		UE_LOG(LogTemp, Display, TEXT("Static Mesh Bounds Box: %s"), *VisualMesh->GetStaticMesh()->GetBounds().GetBox().ToString());
		UE_LOG(LogTemp, Display, TEXT("Static Mesh Bounds Box Max: %s"), *VisualMesh->GetStaticMesh()->GetBounds().GetBox().Max.ToString());
		UE_LOG(LogTemp, Display, TEXT("Static Mesh Bounds Box Min: %s"), *VisualMesh->GetStaticMesh()->GetBounds().GetBox().Min.ToString());

		float* points = (float*)malloc(4);
		points[0] = VisualMesh->GetStaticMesh()->GetBounds().GetBox().Min.X;
		points[1] = VisualMesh->GetStaticMesh()->GetBounds().GetBox().Max.X;
		points[2] = VisualMesh->GetStaticMesh()->GetBounds().GetBox().Min.Y;
		points[3] = VisualMesh->GetStaticMesh()->GetBounds().GetBox().Max.X;
		//UStaticMeshSocket* s0;
		//UStaticMeshSocket* s1;
		//UStaticMeshSocket* s2;
		//UStaticMeshSocket* s3;
		////Setting the socket information
		//VisualMesh->GetStaticMesh()->AddSocket(s0);
		//VisualMesh->GetStaticMesh()->AddSocket(s1);
		//VisualMesh->GetStaticMesh()->AddSocket(s2);
		//VisualMesh->GetStaticMesh()->AddSocket(s3);
		
	}
	else {
		UE_LOG(LogTemp,	Error, TEXT("Buoyant Placement Visual Mesh Static Mesh Not Specified"));
	}
}

// Called every frame
void ABuoyancyPlacement::Tick(float DeltaTime)
{
	Super::Tick(DeltaTime);
	
}

void ABuoyancyPlacement::ReturnPoints(FName PontoonCenterSocket, FVector PontoonRelativeLocation, float PontoonRadius)
{

}
