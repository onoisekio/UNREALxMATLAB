// Fill out your copyright notice in the Description page of Project Settings.

#include "IceSpawnerClass.h"
#include "HAL/FileManager.h"
#include "BuoyancyComponent.h"
#include <MyBuoyancyComponent.h>
#include <math.h>
#include <string>
#include "Algo/Reverse.h"
#include "..\..\..\..\..\..\..\..\..\Program Files\Epic Games\UE_4.26\Engine\Source\Runtime\XmlParser\Public\FastXml.h"
#include "..\..\..\..\..\..\..\..\..\Program Files\Epic Games\UE_4.26\Engine\Source\Runtime\XmlParser\Public\XmlFile.h"
#include "..\..\..\..\..\..\..\..\..\Program Files\Epic Games\UE_4.26\Engine\Source\Runtime\XmlParser\Public\XmlNode.h"

// Sets default values
AIceSpawnerClass::AIceSpawnerClass()
{
 	// Set this actor to call Tick() every frame.  You can turn this off to improve performance if you don't need it.
	PrimaryActorTick.bCanEverTick = true;
}

// Called when the game starts or when spawned
void AIceSpawnerClass::BeginPlay() 
{
	Super::BeginPlay();
	Init();
	SpawnAllRegions();
	//SpawnNextRegion();
}

void AIceSpawnerClass::Init() {
	UE_LOG(LogTemp, Log, TEXT("Initializing Ice Pieces..."));
	if (UseXML) {
		UE_LOG(LogTemp, Log, TEXT("Using XML"));

		if (XMLFilePath == "") {
			UE_LOG(LogTemp, Error, TEXT("XMLFilePath not assigned in Ice Spawner Blueprint"));
			return;
		}

		if (ActorsToSpawn.Num() == 0) {
			UE_LOG(LogTemp, Error, TEXT("ActorsToSpawn not assigned in Ice Spawner Blueprint"));
			return;
		}

		FTransform actorTransform = GetActorTransform();
		FTransform transform = FTransform(actorTransform);

		FXmlFile IceXml(XMLFilePath, EConstructMethod::ConstructFromFile);

		const FXmlNode* IceConcentrations = IceXml.GetRootNode();
		if (!IceConcentrations) {
			UE_LOG(LogTemp, Error, TEXT("No IceConcentration from specified XMLFilePath"));
			return;
		}

		UE_LOG(LogTemp, Warning, TEXT("RootNode tag is: %s"), *IceConcentrations->GetTag());

		TArray<FXmlNode*> Regions = IceConcentrations->GetChildrenNodes();
		if (Regions.Num() <= 0) {
			UE_LOG(LogTemp, Error, TEXT("No Regions under IceConcentration"));
			return;
		}
		int iceCount = 0;
		for (int r = 0; r < Regions.Num(); r++) {
			TArray<FXmlNode*> Pieces = Regions[r]->GetChildrenNodes();
			if (Pieces.Num() <= 0) {
				UE_LOG(LogTemp, Error, TEXT("No valid IcePieces under Region"));
				continue;
			}

			UE_LOG(LogTemp, Warning, TEXT("Getting Ice Pieces for Region %d"), r);

			TArray<TArray<FVector>> IcePiece;

			for (int i = 0; i < Pieces.Num(); i++) {
				TArray<FXmlNode*> Info = Pieces[i]->GetChildrenNodes();
				if (Info.Num() <= 0) {
					UE_LOG(LogTemp, Error, TEXT("No valid IceInfo under IcePiece"));
					continue;
				}

				auto type = *Info[0]->GetContent();//use later to set the texture of the ice
				auto xLoc = *Info[1]->GetContent();
				auto yLoc = *Info[2]->GetContent();
				auto zLoc = *Info[3]->GetContent();
				auto xSpan = *Info[4]->GetContent();
				auto ySpan = *Info[5]->GetContent();
				auto zSpan = *Info[6]->GetContent();

				float iType = std::stof(type);

				if (iType == 0) continue;//spawn nothing

				float xPos = 100 * std::stof(xLoc);
				float yPos = 100 * std::stof(yLoc);
				float zPos = 100 * std::stof(zLoc);

				float xSizeInCM = (std::stof(xSpan) * 100) - 30;
				float ySizeInCM = (std::stof(ySpan) * 100) - 30;
				float zSizeInCM = std::stof(zSpan);

				TArray<FVector> IceInfo = {FVector(xPos, yPos, zPos), FVector(xSizeInCM, ySizeInCM, zSizeInCM)};
				IcePiece.Push(IceInfo);
				iceCount++;
				//return;
			}
			IceRegions.Push(IcePiece);
		}
		//reverse so we start from the smaller/first region
		Algo::Reverse(IceRegions);
		UE_LOG(LogTemp, Warning, TEXT("Init %d ice pieces"), iceCount);
	}
	UE_LOG(LogTemp, Log, TEXT("....Done Initializing Ice Pieces"));
}

void AIceSpawnerClass::SpawnAllRegions() {
	if (UseXML) {
		/*UE_LOG(LogTemp, Log, TEXT("Using XML"));

		if (XMLFilePath == "") {
			UE_LOG(LogTemp, Error, TEXT("XMLFilePath not assigned in Ice Spawner Blueprint"));
			return;
		}

		if (ActorsToSpawn.Num() == 0) {
			UE_LOG(LogTemp, Error, TEXT("ActorsToSpawn not assigned in Ice Spawner Blueprint"));
			return;
		}

		FTransform actorTransform = GetActorTransform();
		FTransform transform = FTransform(actorTransform);

		FXmlFile IceXml(XMLFilePath, EConstructMethod::ConstructFromFile);

		const FXmlNode* IceConcentrations = IceXml.GetRootNode();
		if (!IceConcentrations) {
			UE_LOG(LogTemp, Error, TEXT("No IceConcentration from specified XMLFilePath"));
			return;
		}

		UE_LOG(LogTemp, Warning, TEXT("RootNode tag is: %s"), *IceConcentrations->GetTag());

		TArray<FXmlNode*> Regions = IceConcentrations->GetChildrenNodes();
		if (Regions.Num() <= 0) {
			UE_LOG(LogTemp, Error, TEXT("No Regions under IceConcentration"));
			return;
		}
		int iceCount = 0;
		for (int r = 0; r < Regions.Num(); r++) {
			TArray<FXmlNode*> IcePieces = Regions[r]->GetChildrenNodes();
			if (IcePieces.Num() <= 0) {
				UE_LOG(LogTemp, Error, TEXT("No valid IcePieces under Region"));
				continue;
			}

			for (int i = 0; i < IcePieces.Num(); i++) {
				TArray<FXmlNode*> IceInfo = IcePieces[i]->GetChildrenNodes();
				if (IceInfo.Num() <= 0) {
					UE_LOG(LogTemp, Error, TEXT("No valid IceInfo under IcePiece"));
					continue;
				}

				auto type = *IceInfo[0]->GetContent();//use later to set the texture of the ice
				auto xLoc = *IceInfo[1]->GetContent();
				auto yLoc = *IceInfo[2]->GetContent();
				auto zLoc = *IceInfo[3]->GetContent();
				auto xSpan = *IceInfo[4]->GetContent();
				auto ySpan = *IceInfo[5]->GetContent();
				auto zSpan = *IceInfo[6]->GetContent();

				float iType = std::stof(type);

				if (iType == 0) continue;//spawn nothing

				float xPos = 100 * std::stof(xLoc);
				float yPos = 100 * std::stof(yLoc);
				float zPos = 100 * std::stof(zLoc);
				float xSizeInCM = (std::stof(xSpan) * 100);
				float ySizeInCM = (std::stof(ySpan) * 100);
				float zSizeInCM = std::stof(zSpan);//already in cm in the xml

				SpawnIcePiece(FVector(xPos, yPos, zPos), FVector(xSizeInCM, ySizeInCM, zSizeInCM));

				return;
			}
		}
		UE_LOG(LogTemp, Warning, TEXT("spawned %d ice pieces"), iceCount);*/
		//cleaar the first couple of regions where the ship is
		IceRegions.Pop();
		IceRegions.Pop();
		IceRegions.Pop();
		IceRegions.Pop();
		IceRegions.Pop();
		while (IceRegions.Num() > 0) {
			TArray<TArray<FVector>> Region = IceRegions.Pop();
			while (Region.Num() > 0) {
				TArray<FVector> Piece = Region.Pop();
				FVector pos = Piece[0];
				FVector size = Piece[1];

				SpawnIcePiece(pos, size);
			}
		}
	}
	else {
		UE_LOG(LogTemp, Log, TEXT("Not using XML"));

		if (ActorsToSpawn.Num() <= 0) {
			UE_LOG(LogTemp, Error, TEXT("ActorsToSpawn not assigned in Ice Spawner Blueprint"));
			return;
		}

		if (VisualMeshes.Num() <= 0) {
			UE_LOG(LogTemp, Error, TEXT("VisualMeshs not assigned in Ice Spawner Blueprint"));
			return;
		}

		if (ActorsToSpawn.Num() != VisualMeshes.Num()) {
			UE_LOG(LogTemp, Error, TEXT("VisualMeshs not same length as ActorsToSpawn in Ice Spawner Blueprint"));
			return;
		}

		Super::BeginPlay();
		FTransform actorTransform = GetActorTransform();
		FTransform transform = FTransform(actorTransform);

		int index = rand() % (ActorsToSpawn.Num()) + 1;

		float xSize = VisualMeshes[index - 1]->GetBoundingBox().GetSize().X;
		float ySize = VisualMeshes[index - 1]->GetBoundingBox().GetSize().Y;

		float unitSize = GetUnitSize(index - 1); //size we want in cm

		float xScale = unitSize / xSize;
		float yScale = unitSize / ySize;
		float zScale = 1;

		UE_LOG(LogTemp, Warning, TEXT("Scale: %f %f %f"), transform.GetScale3D().X, transform.GetScale3D().Y, transform.GetScale3D().Z);
		std::vector<FVector> locs;
		locs = GetLocations();

		for (int i = 0; i < locs.size(); i++) {
			UE_LOG(LogTemp, Warning, TEXT("Location: %f %f %f"), locs[i].X, locs[i].Y, locs[i].Z);
			AActor* a = GetWorld()->SpawnActor<AActor>(ActorsToSpawn[index - 1], transform);
			a->SetActorScale3D(FVector(xScale, yScale, zScale));
			UE_LOG(LogTemp, Warning, TEXT("Scale: %f %f %f"), xScale, yScale, zScale);
			a->SetActorLocation(locs[i]);
			a->Reset();
		}
	}
}

void AIceSpawnerClass::SpawnNextRegion() {
	UE_LOG(LogTemp, Log, TEXT("Spawning Next Region..."));
	//ClearActiveIcePieces();
	if (UseXML) {
		if (IceRegions.Num() <= 0) return;

		TArray<TArray<FVector>> Region = IceRegions.Pop();
		while (Region.Num() > 0) {
			TArray<FVector> Piece = Region.Pop();
			FVector pos = Piece[0];
			FVector size = Piece[1];

			SpawnIcePiece(pos, size);
		}
	}
	UE_LOG(LogTemp, Log, TEXT("...Done Spawning Next Region"));
}

void AIceSpawnerClass::ClearActiveIcePieces() {
	UE_LOG(LogTemp, Log, TEXT("Clearing Active Ice Pieces..."));
	if (ActiveIcePieces.Num() <= 0) return;

	for (int i = 0; i < ActiveIcePieces.Num(); i++) {
		ActiveIcePieces[i]->BeginDestroy();
	}
	UE_LOG(LogTemp, Log, TEXT("...Done Clearing Active Ice Pieces"));
}

void AIceSpawnerClass::SpawnIcePiece(FVector pos, FVector sizeInCM) {
	int index = rand() % (ActorsToSpawn.Num()) + 1;

	FTransform actorTransform = GetActorTransform();
	FTransform transform = FTransform(actorTransform);

	//default mesh sizes if the scale was (1,1,1)
	float xSizeDefInCM = VisualMeshes[index - 1]->GetBoundingBox().GetSize().X;
	float ySizeDefInCM = VisualMeshes[index - 1]->GetBoundingBox().GetSize().Y;
	float zSizeDefInCM = VisualMeshes[index - 1]->GetBoundingBox().GetSize().Z;

	float pontoonPoints[6] = { -xSizeDefInCM / 2, 0, xSizeDefInCM / 2, -ySizeDefInCM / 2, 0, ySizeDefInCM / 2 };

	float xScale = sizeInCM.X / xSizeDefInCM;
	float yScale = sizeInCM.Y / ySizeDefInCM;
	float zScale = sizeInCM.Z / zSizeDefInCM;

	float surfaceAreaDefInCM2 = xSizeDefInCM * ySizeDefInCM;
	float surfaceAreaInCM2 = sizeInCM.X * sizeInCM.Y;

	float volumeDefInCM3 = surfaceAreaDefInCM2 * zSizeDefInCM;
	float volumeInCM3 = surfaceAreaInCM2 * sizeInCM.Z;

	AActor* actor = GetWorld()->SpawnActor<AActor>(ActorsToSpawn[index - 1], transform);
	if (actor == nullptr) {
		UE_LOG(LogTemp, Error, TEXT("Actor set to null..."));
		return;
	}

	UStaticMeshComponent* MyStaticMeshComp = actor->FindComponentByClass<UStaticMeshComponent>();
	if (MyStaticMeshComp == nullptr) {
		UE_LOG(LogTemp, Error, TEXT("Actor does not have a StaticMesh component attached"));
		return;
	}

	float volumeScale = (volumeInCM3 / volumeDefInCM3) < 1 ? 1 : (volumeInCM3 / volumeDefInCM3);
	float surfaceAreaScale = (surfaceAreaInCM2 / surfaceAreaDefInCM2) < 1 ? 1 : (surfaceAreaInCM2 / surfaceAreaDefInCM2);

	MyStaticMeshComp->SetAllMassScale(volumeScale);
	UE_LOG(LogTemp, Log, TEXT("%f volume scale"), volumeScale);
	MyStaticMeshComp->SetLinearDamping(0.01 * volumeScale * volumeScale);//exp(volumeScale));
	MyStaticMeshComp->SetAngularDamping(volumeScale * volumeScale);//exp(volumeScal
	//MyStaticMeshComp->SetSimulatePhysics(false);

	//getting the buoyancy information
	UMyBuoyancyComponent* MyBuoyancyComp = actor->FindComponentByClass<UMyBuoyancyComponent>();
	if (MyBuoyancyComp == nullptr) {
		UE_LOG(LogTemp, Error, TEXT("Actor does not have a MyBuoyancy component attached"));
		return;
	}

	//MyBuoyancyComp->BuoyancyData.bApplyDragForcesInWater = true;
	MyBuoyancyComp->BuoyancyData.BuoyancyCoefficient = volumeScale * volumeScale;//
	MyBuoyancyComp->BuoyancyData.BuoyancyDamp = 1000 * surfaceAreaScale;
	MyBuoyancyComp->BuoyancyData.BuoyancyDamp2 = surfaceAreaScale;
	MyBuoyancyComp->BuoyancyData.BuoyancyRampMinVelocity = 20 * surfaceAreaScale;
	MyBuoyancyComp->BuoyancyData.BuoyancyRampMaxVelocity = 50 * surfaceAreaScale;
	MyBuoyancyComp->BuoyancyData.BuoyancyRampMax = surfaceAreaScale;
	MyBuoyancyComp->BuoyancyData.MaxBuoyantForce = 5000000 * surfaceAreaScale;//exp(surfaceAreaScale);//pow(1.015625, volumeScale);
	MyBuoyancyComp->BuoyancyData.DragCoefficient = 20 * surfaceAreaScale;
	MyBuoyancyComp->BuoyancyData.DragCoefficient2 = 0.01 * surfaceAreaScale;
	MyBuoyancyComp->BuoyancyData.AngularDragCoefficient = surfaceAreaScale;
	MyBuoyancyComp->BuoyancyData.MaxDragSpeed = 15 * volumeScale;

	for (int x = 0; x <= 2; x++) {
		for (int y = 3; y <= 5; y++) {
			MyBuoyancyComp->AddPontoon(FVector(pontoonPoints[x], pontoonPoints[y], zSizeDefInCM / 2), sizeInCM.Z);
			//MyBuoyancyComp->AddPontoon(FVector(pontoonPoints[x], pontoonPoints[y], 0), sizeInCM.Z);
		}
	}

	actor->SetActorScale3D(FVector(xScale, yScale, zScale));
	actor->SetActorLocation(FVector(pos.X, pos.Y, 0));
	ActiveIcePieces.Add(actor);
}

std::vector<FVector> AIceSpawnerClass::GetLocations() {
	
	if (locations.size() > 0) return locations;

	//static FVector output[];
	FTransform origin = GetActorTransform();
	float unitSize = 100;//TODO: change later
	float maxX = (origin.GetLocation().X + (dimension / 2)) - (unitSize / 2);
	float minX = (origin.GetLocation().X - (dimension / 2)) + (unitSize / 2);
	float maxY = (origin.GetLocation().Y + (dimension / 2)) - (unitSize / 2);
	float minY = (origin.GetLocation().Y - (dimension / 2)) + (unitSize / 2);
	float z = origin.GetLocation().Z;

	//UE_LOG(LogTemp, Warning, TEXT(""));

	//adding the locations to the vector
	for (float x = minX; x <= maxX; x += unitSize)
		for (float y = minY; y <= maxY; y += unitSize)
			locations.push_back(FVector(x, y, z));
			
	UE_LOG(LogTemp, Warning, TEXT("gETING lOCATION"));
	return locations;
}

float AIceSpawnerClass::GetUnitSize(int index) {
	if (dimension == NULL) {
		UE_LOG(LogTemp, Error, TEXT("dimension not assigned in Ice Spawner Blueprint"));
		return 0;
	}
	
	if (n == NULL) {
		UE_LOG(LogTemp, Error, TEXT("n not assigned in Ice Spawner Blueprint"));
		return 0;
	}

	float xSize = VisualMeshes[index]->GetBoundingBox().GetSize().X;
	float ySize = VisualMeshes[index]->GetBoundingBox().GetSize().Y;

	float unitSize = (n > -1) ? (dimension / pow(2, n)) : std::max(xSize, ySize); //size we want in cm
	
	return unitSize;
}

// Called every frame
void AIceSpawnerClass::Tick(float DeltaTime)
{
	Super::Tick(DeltaTime);
	SpawnNextRegion();
}