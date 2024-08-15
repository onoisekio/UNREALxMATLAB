// Fill out your copyright notice in the Description page of Project Settings.

#include "MyBuoyancyComponent.h"
#include "Engine/StaticMeshSocket.h"

/// <summary>
/// Adds pontoons to different points on the bound of the static mesh
/// </summary>
/// <param name="PontoonCount"></param>
/// <param name="VisualMesh"></param>
/// <returns>Returns the number of pontoons added to the static mesh</returns>
int32 UMyBuoyancyComponent::AddPontoons(UStaticMeshComponent* VisualMesh) {
	if (!VisualMesh)
		return 0;
	if (!VisualMesh->GetStaticMesh())
		return 0;
	
	float xScale = VisualMesh->GetRelativeScale3D().X;
	float yScale = VisualMesh->GetRelativeScale3D().Y;
	float zScale = VisualMesh->GetRelativeScale3D().Z;

	float xSize = VisualMesh->GetStaticMesh()->GetBoundingBox().GetSize().X * xScale;
	float ySize = VisualMesh->GetStaticMesh()->GetBoundingBox().GetSize().Y * yScale;
	float zSize = VisualMesh->GetStaticMesh()->GetBoundingBox().GetSize().Z * zScale;

	float oVolume = (xSize / xScale) * (ySize / yScale) * (zSize / zScale);
	float nVolume = xSize * ySize * zSize;

	int pontoonRad = zSize;//75 * nVolume / oVolume;//setting the pontoon radius to be the thickeness of the structure
	int pontoonCount = 0;

	float points[6] =
	{ VisualMesh->GetStaticMesh()->GetBoundingBox().Min.X,
	VisualMesh->GetStaticMesh()->GetBoundingBox().Max.X,
	VisualMesh->GetStaticMesh()->GetBoundingBox().Min.Y,
	VisualMesh->GetStaticMesh()->GetBoundingBox().Max.Y,
	VisualMesh->GetStaticMesh()->GetBoundingBox().Min.Z,
	VisualMesh->GetStaticMesh()->GetBoundingBox().Max.Z };

	//creating pontoons as points on the actual mesh bound
	//Getting the vertices from the static mesh
	TArray<FVector> vertices;
	//VertexBuffer containing the position vertex data
	FPositionVertexBuffer* VertexBuffer = &VisualMesh->GetStaticMesh()->RenderData->LODResources[0].VertexBuffers.PositionVertexBuffer;

	//getting the accurate vertices from the static mesh
	if (VertexBuffer) {
		const int32 VertexCount = VertexBuffer->GetNumVertices();
		for (int32 i = 0; i < VertexCount; i++) {
			const FVector WorlSpaceVertexLocation = VertexBuffer->VertexPosition(i);
			vertices.Add(WorlSpaceVertexLocation);
		}
	}
	//adding the pontoons
	for (int v = 0; v < vertices.Num(); v += 1000) {
		for (int z = 4; z <= 5; z++) {
			FSphericalPontoon pontoon = FSphericalPontoon();
			pontoon.RelativeLocation = FVector(vertices[v].X, vertices[v].Y, 0);
			pontoon.Radius = pontoonRad;
			BuoyancyData.Pontoons.Add(pontoon);
			pontoonCount++;
		}
	}

	//creating pontoons as points on the mesh cube bound
	/*for (float x = points[0]; x <= points[1]; x += 5) {
		for (float y = points[2]; y <= points[3]; y += 5) {
			for (int z = 4; z <= 5; z++) {
				FSphericalPontoon pontoon = FSphericalPontoon();
				pontoon.RelativeLocation = FVector(x, y, points[z]);
				pontoon.Radius = pontoonRad;
				BuoyancyData.Pontoons.Add(pontoon);
				pontoonCount++;
				//UE_LOG(LogTemp, Warning, TEXT("%d %f %f %f"), pontoonCount, x, y, z);
				//UE_LOG(LogTemp, Warning, TEXT("%f %f %f %f %f %f"), points[0], points[1], points[2], points[3], points[4], points[5]);
			}
		}
	}*/
	
			
	//creating pontoons at 9 points on the bound box of the static mesh
	/*
	FSphericalPontoon pontoon0 = FSphericalPontoon();
	FSphericalPontoon pontoon1 = FSphericalPontoon();
	FSphericalPontoon pontoon2 = FSphericalPontoon();
	FSphericalPontoon pontoon3 = FSphericalPontoon();
	FSphericalPontoon pontoon4 = FSphericalPontoon();
	FSphericalPontoon pontoon5 = FSphericalPontoon();
	FSphericalPontoon pontoon6 = FSphericalPontoon();
	FSphericalPontoon pontoon7 = FSphericalPontoon();
	FSphericalPontoon pontoon8 = FSphericalPontoon();

	pontoon0.CenterSocket = "";
	pontoon1.CenterSocket = "";
	pontoon2.CenterSocket = "";
	pontoon3.CenterSocket = "";
	pontoon4.CenterSocket = "";
	pontoon5.CenterSocket = "";
	pontoon6.CenterSocket = "";
	pontoon7.CenterSocket = "";
	pontoon8.CenterSocket = "";

	pontoon0.RelativeLocation = FVector(0, 0, 0);
	pontoon1.RelativeLocation = FVector(points[0],points[2],points[4]);
	pontoon2.RelativeLocation = FVector(points[0],points[2],points[5]);
	pontoon3.RelativeLocation = FVector(points[0],points[3],points[4]);
	pontoon4.RelativeLocation = FVector(points[0],points[3],points[5]);
	pontoon5.RelativeLocation = FVector(points[1],points[2],points[4]);
	pontoon6.RelativeLocation = FVector(points[1],points[2],points[5]);
	pontoon7.RelativeLocation = FVector(points[1],points[3],points[4]);
	pontoon8.RelativeLocation = FVector(points[1],points[3],points[5]);

	int rad = 80;

	pontoon0.Radius = rad;
	pontoon1.Radius = rad;
	pontoon2.Radius = rad;
	pontoon3.Radius = rad;
	pontoon4.Radius = rad;
	pontoon5.Radius = rad;
	pontoon6.Radius = rad;
	pontoon7.Radius = rad;
	pontoon8.Radius = rad;

	BuoyancyData.Pontoons.Add(pontoon0);
	BuoyancyData.Pontoons.Add(pontoon1);
	BuoyancyData.Pontoons.Add(pontoon2);
	BuoyancyData.Pontoons.Add(pontoon3);
	BuoyancyData.Pontoons.Add(pontoon4);
	BuoyancyData.Pontoons.Add(pontoon5);
	BuoyancyData.Pontoons.Add(pontoon6);
	BuoyancyData.Pontoons.Add(pontoon7);
	BuoyancyData.Pontoons.Add(pontoon8);
	*/
	EnableTick();
	return pontoonCount;
	//FSphericalPontoon pontoon = FSphericalPontoon();
	//pontoon.CenterSocket = PontoonCenterSocket;
	//pontoon.RelativeLocation = PontoonRelativeLocation;
	//pontoon.Radius = PontoonRadius;
	//BuoyancyData.Pontoons.Add(pontoon);
}

/// <summary>
/// Add single pontoon to buoyancy component returning 1 after completing operation
/// </summary>
/// <param name="RelativeLocation"></param>
/// <param name="Radius"></param>
/// <returns></returns>
int32 UMyBuoyancyComponent::AddPontoon(FVector RelativeLocation, float Radius) {
	FSphericalPontoon pontoon = FSphericalPontoon();
	pontoon.CenterSocket = FName("Socket");
	pontoon.RelativeLocation = RelativeLocation;
	pontoon.Radius = Radius;
	//UE_LOG(LogTemp, Log, TEXT("adding pontoons to (%f %f %f)"), RelativeLocation.X, RelativeLocation.Y, RelativeLocation.Z);
	BuoyancyData.Pontoons.Add(pontoon);
	//UE_LOG(LogTemp, Log, TEXT("pontoon added"));

	return 1;
}

void UMyBuoyancyComponent::PresetBuoyancy(UStaticMeshComponent* VisualMesh) {
	if (!VisualMesh)
		return;
	if (!VisualMesh->GetStaticMesh())
		return;

	float mass = VisualMesh->GetMass();

	SetAutoActivate(true);

	//BuoyancyData.BuoyancyCoefficient = (0.1 * nVolume) / oVolume;//density of ice in g/cm^3
	BuoyancyData.BuoyancyCoefficient = (stdBCoeff * mass) / stdMass;
	BuoyancyData.BuoyancyDamp = (stdBDamp * mass) / stdMass;
	BuoyancyData.BuoyancyDamp2 = (stdBDamp2 * mass) / stdMass;
	BuoyancyData.BuoyancyRampMinVelocity = (stdBRampMinV * mass) / stdMass;
	BuoyancyData.BuoyancyRampMaxVelocity = (stdBRampMaxV * mass) / stdMass;
	BuoyancyData.BuoyancyRampMax = (stdBRampMax * mass) / stdMass;
	BuoyancyData.MaxBuoyantForce = (stdMaxBForce * mass) / stdMass;
	BuoyancyData.WaterShorePushFactor = (stdWaterShorePushFactor * mass) / stdMass;
	BuoyancyData.WaterVelocityStrength = (stdWaterVelocityStrength * mass) / stdMass;
	BuoyancyData.MaxWaterForce = (stdMaxWaterForce * mass) / stdMass;
}

void UMyBuoyancyComponent::PresetPhysics(UStaticMeshComponent* VisualMesh) {
	float stdIceDensity = 0.917 / 1000;//g/cm^3 to kg/cm^3
	VisualMesh->SetSimulatePhysics(true);
	VisualMesh->SetEnableGravity(true);

	float xScale = VisualMesh ->GetRelativeScale3D().X;
	float yScale = VisualMesh->GetRelativeScale3D().Y;
	float zScale = VisualMesh->GetRelativeScale3D().Z;

	float xSize = VisualMesh->GetStaticMesh()->GetBoundingBox().GetSize().X * xScale;
	float ySize = VisualMesh->GetStaticMesh()->GetBoundingBox().GetSize().Y * yScale;
	float zSize = VisualMesh->GetStaticMesh()->GetBoundingBox().GetSize().Z * zScale;
	float oVolume = (xSize / xScale) * (ySize / yScale) * (zSize / zScale);
	float nVolume = xSize * ySize * zSize;

	//UE_LOG(LogTemp, Warning, TEXT("old xSize: %f, new xSize: %f"), xSize/xScale, xSize);

	//getting an approximation of the mesh's maximum surface area
	float surfaceArea = xSize * ySize;
	float oMass = VisualMesh->GetMass();
	//float newMass = volume * stdIceDensity;
	float newMass = stdIceDensity * nVolume;//(oMass * nVolume) / oVolume;
	float aDamping = (stdADamp * (xSize * ySize)) / (stdXSize * stdYSize);//(stdDamp*surfaceArea)/stdArea;
	float lDamping = (stdLDamp * newMass) / stdMass;
	//VisualMesh->SetMassOverrideInKg(NAME_None, newMass, true);//setting the new mass in kg
	//float s = VisualMesh->GetMassScale();

	//float newScale = newMass / oMass;
	//VisualMesh->SetAllMassScale(newScale);
	float nM = VisualMesh->GetMass();
	//set the angular damping
	VisualMesh->SetAngularDamping(aDamping);
	VisualMesh->SetLinearDamping(lDamping);

	UE_LOG(LogTemp, Warning, TEXT("old Mass: %f, new Mass: %f, newMass?: %f, aDamping: %f, lDamping: %f"), oMass, newMass, nM, aDamping, lDamping);
}