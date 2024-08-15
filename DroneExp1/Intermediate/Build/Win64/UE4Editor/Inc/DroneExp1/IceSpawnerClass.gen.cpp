// Copyright Epic Games, Inc. All Rights Reserved.
/*===========================================================================
	Generated code exported from UnrealHeaderTool.
	DO NOT modify this manually! Edit the corresponding .h files instead!
===========================================================================*/

#include "UObject/GeneratedCppIncludes.h"
#include "DroneExp1/Public/IceSpawnerClass.h"
#ifdef _MSC_VER
#pragma warning (push)
#pragma warning (disable : 4883)
#endif
PRAGMA_DISABLE_DEPRECATION_WARNINGS
void EmptyLinkFunctionForGeneratedCodeIceSpawnerClass() {}
// Cross Module References
	DRONEEXP1_API UClass* Z_Construct_UClass_AIceSpawnerClass_NoRegister();
	DRONEEXP1_API UClass* Z_Construct_UClass_AIceSpawnerClass();
	ENGINE_API UClass* Z_Construct_UClass_AActor();
	UPackage* Z_Construct_UPackage__Script_DroneExp1();
	COREUOBJECT_API UScriptStruct* Z_Construct_UScriptStruct_FVector();
	COREUOBJECT_API UClass* Z_Construct_UClass_UClass();
	ENGINE_API UClass* Z_Construct_UClass_AActor_NoRegister();
	ENGINE_API UClass* Z_Construct_UClass_UStaticMesh_NoRegister();
// End Cross Module References
	DEFINE_FUNCTION(AIceSpawnerClass::execClearActiveIcePieces)
	{
		P_FINISH;
		P_NATIVE_BEGIN;
		P_THIS->ClearActiveIcePieces();
		P_NATIVE_END;
	}
	DEFINE_FUNCTION(AIceSpawnerClass::execSpawnIcePiece)
	{
		P_GET_STRUCT(FVector,Z_Param_pos);
		P_GET_STRUCT(FVector,Z_Param_size);
		P_FINISH;
		P_NATIVE_BEGIN;
		P_THIS->SpawnIcePiece(Z_Param_pos,Z_Param_size);
		P_NATIVE_END;
	}
	DEFINE_FUNCTION(AIceSpawnerClass::execSpawnAllRegions)
	{
		P_FINISH;
		P_NATIVE_BEGIN;
		P_THIS->SpawnAllRegions();
		P_NATIVE_END;
	}
	DEFINE_FUNCTION(AIceSpawnerClass::execSpawnNextRegion)
	{
		P_FINISH;
		P_NATIVE_BEGIN;
		P_THIS->SpawnNextRegion();
		P_NATIVE_END;
	}
	DEFINE_FUNCTION(AIceSpawnerClass::execInit)
	{
		P_FINISH;
		P_NATIVE_BEGIN;
		P_THIS->Init();
		P_NATIVE_END;
	}
	void AIceSpawnerClass::StaticRegisterNativesAIceSpawnerClass()
	{
		UClass* Class = AIceSpawnerClass::StaticClass();
		static const FNameNativePtrPair Funcs[] = {
			{ "ClearActiveIcePieces", &AIceSpawnerClass::execClearActiveIcePieces },
			{ "Init", &AIceSpawnerClass::execInit },
			{ "SpawnAllRegions", &AIceSpawnerClass::execSpawnAllRegions },
			{ "SpawnIcePiece", &AIceSpawnerClass::execSpawnIcePiece },
			{ "SpawnNextRegion", &AIceSpawnerClass::execSpawnNextRegion },
		};
		FNativeFunctionRegistrar::RegisterFunctions(Class, Funcs, UE_ARRAY_COUNT(Funcs));
	}
	struct Z_Construct_UFunction_AIceSpawnerClass_ClearActiveIcePieces_Statics
	{
#if WITH_METADATA
		static const UE4CodeGen_Private::FMetaDataPairParam Function_MetaDataParams[];
#endif
		static const UE4CodeGen_Private::FFunctionParams FuncParams;
	};
#if WITH_METADATA
	const UE4CodeGen_Private::FMetaDataPairParam Z_Construct_UFunction_AIceSpawnerClass_ClearActiveIcePieces_Statics::Function_MetaDataParams[] = {
		{ "Category", "IceSpawner" },
		{ "ModuleRelativePath", "Public/IceSpawnerClass.h" },
	};
#endif
	const UE4CodeGen_Private::FFunctionParams Z_Construct_UFunction_AIceSpawnerClass_ClearActiveIcePieces_Statics::FuncParams = { (UObject*(*)())Z_Construct_UClass_AIceSpawnerClass, nullptr, "ClearActiveIcePieces", nullptr, nullptr, 0, nullptr, 0, RF_Public|RF_Transient|RF_MarkAsNative, (EFunctionFlags)0x04020401, 0, 0, METADATA_PARAMS(Z_Construct_UFunction_AIceSpawnerClass_ClearActiveIcePieces_Statics::Function_MetaDataParams, UE_ARRAY_COUNT(Z_Construct_UFunction_AIceSpawnerClass_ClearActiveIcePieces_Statics::Function_MetaDataParams)) };
	UFunction* Z_Construct_UFunction_AIceSpawnerClass_ClearActiveIcePieces()
	{
		static UFunction* ReturnFunction = nullptr;
		if (!ReturnFunction)
		{
			UE4CodeGen_Private::ConstructUFunction(ReturnFunction, Z_Construct_UFunction_AIceSpawnerClass_ClearActiveIcePieces_Statics::FuncParams);
		}
		return ReturnFunction;
	}
	struct Z_Construct_UFunction_AIceSpawnerClass_Init_Statics
	{
#if WITH_METADATA
		static const UE4CodeGen_Private::FMetaDataPairParam Function_MetaDataParams[];
#endif
		static const UE4CodeGen_Private::FFunctionParams FuncParams;
	};
#if WITH_METADATA
	const UE4CodeGen_Private::FMetaDataPairParam Z_Construct_UFunction_AIceSpawnerClass_Init_Statics::Function_MetaDataParams[] = {
		{ "Category", "IceSpawner" },
		{ "Comment", "//spawn method\n" },
		{ "ModuleRelativePath", "Public/IceSpawnerClass.h" },
		{ "ToolTip", "spawn method" },
	};
#endif
	const UE4CodeGen_Private::FFunctionParams Z_Construct_UFunction_AIceSpawnerClass_Init_Statics::FuncParams = { (UObject*(*)())Z_Construct_UClass_AIceSpawnerClass, nullptr, "Init", nullptr, nullptr, 0, nullptr, 0, RF_Public|RF_Transient|RF_MarkAsNative, (EFunctionFlags)0x04020401, 0, 0, METADATA_PARAMS(Z_Construct_UFunction_AIceSpawnerClass_Init_Statics::Function_MetaDataParams, UE_ARRAY_COUNT(Z_Construct_UFunction_AIceSpawnerClass_Init_Statics::Function_MetaDataParams)) };
	UFunction* Z_Construct_UFunction_AIceSpawnerClass_Init()
	{
		static UFunction* ReturnFunction = nullptr;
		if (!ReturnFunction)
		{
			UE4CodeGen_Private::ConstructUFunction(ReturnFunction, Z_Construct_UFunction_AIceSpawnerClass_Init_Statics::FuncParams);
		}
		return ReturnFunction;
	}
	struct Z_Construct_UFunction_AIceSpawnerClass_SpawnAllRegions_Statics
	{
#if WITH_METADATA
		static const UE4CodeGen_Private::FMetaDataPairParam Function_MetaDataParams[];
#endif
		static const UE4CodeGen_Private::FFunctionParams FuncParams;
	};
#if WITH_METADATA
	const UE4CodeGen_Private::FMetaDataPairParam Z_Construct_UFunction_AIceSpawnerClass_SpawnAllRegions_Statics::Function_MetaDataParams[] = {
		{ "Category", "IceSpawner" },
		{ "ModuleRelativePath", "Public/IceSpawnerClass.h" },
	};
#endif
	const UE4CodeGen_Private::FFunctionParams Z_Construct_UFunction_AIceSpawnerClass_SpawnAllRegions_Statics::FuncParams = { (UObject*(*)())Z_Construct_UClass_AIceSpawnerClass, nullptr, "SpawnAllRegions", nullptr, nullptr, 0, nullptr, 0, RF_Public|RF_Transient|RF_MarkAsNative, (EFunctionFlags)0x04020401, 0, 0, METADATA_PARAMS(Z_Construct_UFunction_AIceSpawnerClass_SpawnAllRegions_Statics::Function_MetaDataParams, UE_ARRAY_COUNT(Z_Construct_UFunction_AIceSpawnerClass_SpawnAllRegions_Statics::Function_MetaDataParams)) };
	UFunction* Z_Construct_UFunction_AIceSpawnerClass_SpawnAllRegions()
	{
		static UFunction* ReturnFunction = nullptr;
		if (!ReturnFunction)
		{
			UE4CodeGen_Private::ConstructUFunction(ReturnFunction, Z_Construct_UFunction_AIceSpawnerClass_SpawnAllRegions_Statics::FuncParams);
		}
		return ReturnFunction;
	}
	struct Z_Construct_UFunction_AIceSpawnerClass_SpawnIcePiece_Statics
	{
		struct IceSpawnerClass_eventSpawnIcePiece_Parms
		{
			FVector pos;
			FVector size;
		};
		static const UE4CodeGen_Private::FStructPropertyParams NewProp_pos;
		static const UE4CodeGen_Private::FStructPropertyParams NewProp_size;
		static const UE4CodeGen_Private::FPropertyParamsBase* const PropPointers[];
#if WITH_METADATA
		static const UE4CodeGen_Private::FMetaDataPairParam Function_MetaDataParams[];
#endif
		static const UE4CodeGen_Private::FFunctionParams FuncParams;
	};
	const UE4CodeGen_Private::FStructPropertyParams Z_Construct_UFunction_AIceSpawnerClass_SpawnIcePiece_Statics::NewProp_pos = { "pos", nullptr, (EPropertyFlags)0x0010000000000080, UE4CodeGen_Private::EPropertyGenFlags::Struct, RF_Public|RF_Transient|RF_MarkAsNative, 1, STRUCT_OFFSET(IceSpawnerClass_eventSpawnIcePiece_Parms, pos), Z_Construct_UScriptStruct_FVector, METADATA_PARAMS(nullptr, 0) };
	const UE4CodeGen_Private::FStructPropertyParams Z_Construct_UFunction_AIceSpawnerClass_SpawnIcePiece_Statics::NewProp_size = { "size", nullptr, (EPropertyFlags)0x0010000000000080, UE4CodeGen_Private::EPropertyGenFlags::Struct, RF_Public|RF_Transient|RF_MarkAsNative, 1, STRUCT_OFFSET(IceSpawnerClass_eventSpawnIcePiece_Parms, size), Z_Construct_UScriptStruct_FVector, METADATA_PARAMS(nullptr, 0) };
	const UE4CodeGen_Private::FPropertyParamsBase* const Z_Construct_UFunction_AIceSpawnerClass_SpawnIcePiece_Statics::PropPointers[] = {
		(const UE4CodeGen_Private::FPropertyParamsBase*)&Z_Construct_UFunction_AIceSpawnerClass_SpawnIcePiece_Statics::NewProp_pos,
		(const UE4CodeGen_Private::FPropertyParamsBase*)&Z_Construct_UFunction_AIceSpawnerClass_SpawnIcePiece_Statics::NewProp_size,
	};
#if WITH_METADATA
	const UE4CodeGen_Private::FMetaDataPairParam Z_Construct_UFunction_AIceSpawnerClass_SpawnIcePiece_Statics::Function_MetaDataParams[] = {
		{ "Category", "IceSpawner" },
		{ "ModuleRelativePath", "Public/IceSpawnerClass.h" },
	};
#endif
	const UE4CodeGen_Private::FFunctionParams Z_Construct_UFunction_AIceSpawnerClass_SpawnIcePiece_Statics::FuncParams = { (UObject*(*)())Z_Construct_UClass_AIceSpawnerClass, nullptr, "SpawnIcePiece", nullptr, nullptr, sizeof(IceSpawnerClass_eventSpawnIcePiece_Parms), Z_Construct_UFunction_AIceSpawnerClass_SpawnIcePiece_Statics::PropPointers, UE_ARRAY_COUNT(Z_Construct_UFunction_AIceSpawnerClass_SpawnIcePiece_Statics::PropPointers), RF_Public|RF_Transient|RF_MarkAsNative, (EFunctionFlags)0x04820401, 0, 0, METADATA_PARAMS(Z_Construct_UFunction_AIceSpawnerClass_SpawnIcePiece_Statics::Function_MetaDataParams, UE_ARRAY_COUNT(Z_Construct_UFunction_AIceSpawnerClass_SpawnIcePiece_Statics::Function_MetaDataParams)) };
	UFunction* Z_Construct_UFunction_AIceSpawnerClass_SpawnIcePiece()
	{
		static UFunction* ReturnFunction = nullptr;
		if (!ReturnFunction)
		{
			UE4CodeGen_Private::ConstructUFunction(ReturnFunction, Z_Construct_UFunction_AIceSpawnerClass_SpawnIcePiece_Statics::FuncParams);
		}
		return ReturnFunction;
	}
	struct Z_Construct_UFunction_AIceSpawnerClass_SpawnNextRegion_Statics
	{
#if WITH_METADATA
		static const UE4CodeGen_Private::FMetaDataPairParam Function_MetaDataParams[];
#endif
		static const UE4CodeGen_Private::FFunctionParams FuncParams;
	};
#if WITH_METADATA
	const UE4CodeGen_Private::FMetaDataPairParam Z_Construct_UFunction_AIceSpawnerClass_SpawnNextRegion_Statics::Function_MetaDataParams[] = {
		{ "Category", "IceSpawner" },
		{ "ModuleRelativePath", "Public/IceSpawnerClass.h" },
	};
#endif
	const UE4CodeGen_Private::FFunctionParams Z_Construct_UFunction_AIceSpawnerClass_SpawnNextRegion_Statics::FuncParams = { (UObject*(*)())Z_Construct_UClass_AIceSpawnerClass, nullptr, "SpawnNextRegion", nullptr, nullptr, 0, nullptr, 0, RF_Public|RF_Transient|RF_MarkAsNative, (EFunctionFlags)0x04020401, 0, 0, METADATA_PARAMS(Z_Construct_UFunction_AIceSpawnerClass_SpawnNextRegion_Statics::Function_MetaDataParams, UE_ARRAY_COUNT(Z_Construct_UFunction_AIceSpawnerClass_SpawnNextRegion_Statics::Function_MetaDataParams)) };
	UFunction* Z_Construct_UFunction_AIceSpawnerClass_SpawnNextRegion()
	{
		static UFunction* ReturnFunction = nullptr;
		if (!ReturnFunction)
		{
			UE4CodeGen_Private::ConstructUFunction(ReturnFunction, Z_Construct_UFunction_AIceSpawnerClass_SpawnNextRegion_Statics::FuncParams);
		}
		return ReturnFunction;
	}
	UClass* Z_Construct_UClass_AIceSpawnerClass_NoRegister()
	{
		return AIceSpawnerClass::StaticClass();
	}
	struct Z_Construct_UClass_AIceSpawnerClass_Statics
	{
		static UObject* (*const DependentSingletons[])();
		static const FClassFunctionLinkInfo FuncInfo[];
#if WITH_METADATA
		static const UE4CodeGen_Private::FMetaDataPairParam Class_MetaDataParams[];
#endif
#if WITH_METADATA
		static const UE4CodeGen_Private::FMetaDataPairParam NewProp_UseXML_MetaData[];
#endif
		static void NewProp_UseXML_SetBit(void* Obj);
		static const UE4CodeGen_Private::FBoolPropertyParams NewProp_UseXML;
#if WITH_METADATA
		static const UE4CodeGen_Private::FMetaDataPairParam NewProp_XMLFilePath_MetaData[];
#endif
		static const UE4CodeGen_Private::FStrPropertyParams NewProp_XMLFilePath;
		static const UE4CodeGen_Private::FClassPropertyParams NewProp_ActorsToSpawn_Inner;
#if WITH_METADATA
		static const UE4CodeGen_Private::FMetaDataPairParam NewProp_ActorsToSpawn_MetaData[];
#endif
		static const UE4CodeGen_Private::FArrayPropertyParams NewProp_ActorsToSpawn;
		static const UE4CodeGen_Private::FObjectPropertyParams NewProp_VisualMeshes_Inner;
#if WITH_METADATA
		static const UE4CodeGen_Private::FMetaDataPairParam NewProp_VisualMeshes_MetaData[];
#endif
		static const UE4CodeGen_Private::FArrayPropertyParams NewProp_VisualMeshes;
#if WITH_METADATA
		static const UE4CodeGen_Private::FMetaDataPairParam NewProp_n_MetaData[];
#endif
		static const UE4CodeGen_Private::FFloatPropertyParams NewProp_n;
#if WITH_METADATA
		static const UE4CodeGen_Private::FMetaDataPairParam NewProp_dimension_MetaData[];
#endif
		static const UE4CodeGen_Private::FFloatPropertyParams NewProp_dimension;
#if WITH_METADATA
		static const UE4CodeGen_Private::FMetaDataPairParam NewProp_thickness_MetaData[];
#endif
		static const UE4CodeGen_Private::FFloatPropertyParams NewProp_thickness;
		static const UE4CodeGen_Private::FPropertyParamsBase* const PropPointers[];
		static const FCppClassTypeInfoStatic StaticCppClassTypeInfo;
		static const UE4CodeGen_Private::FClassParams ClassParams;
	};
	UObject* (*const Z_Construct_UClass_AIceSpawnerClass_Statics::DependentSingletons[])() = {
		(UObject* (*)())Z_Construct_UClass_AActor,
		(UObject* (*)())Z_Construct_UPackage__Script_DroneExp1,
	};
	const FClassFunctionLinkInfo Z_Construct_UClass_AIceSpawnerClass_Statics::FuncInfo[] = {
		{ &Z_Construct_UFunction_AIceSpawnerClass_ClearActiveIcePieces, "ClearActiveIcePieces" }, // 371208041
		{ &Z_Construct_UFunction_AIceSpawnerClass_Init, "Init" }, // 1407905072
		{ &Z_Construct_UFunction_AIceSpawnerClass_SpawnAllRegions, "SpawnAllRegions" }, // 733488679
		{ &Z_Construct_UFunction_AIceSpawnerClass_SpawnIcePiece, "SpawnIcePiece" }, // 622262109
		{ &Z_Construct_UFunction_AIceSpawnerClass_SpawnNextRegion, "SpawnNextRegion" }, // 4044231920
	};
#if WITH_METADATA
	const UE4CodeGen_Private::FMetaDataPairParam Z_Construct_UClass_AIceSpawnerClass_Statics::Class_MetaDataParams[] = {
		{ "BlueprintSpawnableComponent", "" },
		{ "BlueprintType", "true" },
		{ "IncludePath", "IceSpawnerClass.h" },
		{ "IsBlueprintBase", "true" },
		{ "ModuleRelativePath", "Public/IceSpawnerClass.h" },
	};
#endif
#if WITH_METADATA
	const UE4CodeGen_Private::FMetaDataPairParam Z_Construct_UClass_AIceSpawnerClass_Statics::NewProp_UseXML_MetaData[] = {
		{ "Category", "IceSpawnerClass" },
		{ "Comment", "// Whether to get data from an XML file or not.\n// If using XML file, uses data from XMLFilePath, ActorToSpawn, n, dimension and thickness\n// If not using XML file, uses data from ActorToSpawn, VisualMesh, n, dimension and thickness\n" },
		{ "ModuleRelativePath", "Public/IceSpawnerClass.h" },
		{ "ToolTip", "Whether to get data from an XML file or not.\nIf using XML file, uses data from XMLFilePath, ActorToSpawn, n, dimension and thickness\nIf not using XML file, uses data from ActorToSpawn, VisualMesh, n, dimension and thickness" },
	};
#endif
	void Z_Construct_UClass_AIceSpawnerClass_Statics::NewProp_UseXML_SetBit(void* Obj)
	{
		((AIceSpawnerClass*)Obj)->UseXML = 1;
	}
	const UE4CodeGen_Private::FBoolPropertyParams Z_Construct_UClass_AIceSpawnerClass_Statics::NewProp_UseXML = { "UseXML", nullptr, (EPropertyFlags)0x0010000000010001, UE4CodeGen_Private::EPropertyGenFlags::Bool | UE4CodeGen_Private::EPropertyGenFlags::NativeBool, RF_Public|RF_Transient|RF_MarkAsNative, 1, sizeof(bool), sizeof(AIceSpawnerClass), &Z_Construct_UClass_AIceSpawnerClass_Statics::NewProp_UseXML_SetBit, METADATA_PARAMS(Z_Construct_UClass_AIceSpawnerClass_Statics::NewProp_UseXML_MetaData, UE_ARRAY_COUNT(Z_Construct_UClass_AIceSpawnerClass_Statics::NewProp_UseXML_MetaData)) };
#if WITH_METADATA
	const UE4CodeGen_Private::FMetaDataPairParam Z_Construct_UClass_AIceSpawnerClass_Statics::NewProp_XMLFilePath_MetaData[] = {
		{ "Category", "IceSpawnerClass" },
		{ "Comment", "// XML file path for ice objects\n" },
		{ "ModuleRelativePath", "Public/IceSpawnerClass.h" },
		{ "ToolTip", "XML file path for ice objects" },
	};
#endif
	const UE4CodeGen_Private::FStrPropertyParams Z_Construct_UClass_AIceSpawnerClass_Statics::NewProp_XMLFilePath = { "XMLFilePath", nullptr, (EPropertyFlags)0x0010000000010001, UE4CodeGen_Private::EPropertyGenFlags::Str, RF_Public|RF_Transient|RF_MarkAsNative, 1, STRUCT_OFFSET(AIceSpawnerClass, XMLFilePath), METADATA_PARAMS(Z_Construct_UClass_AIceSpawnerClass_Statics::NewProp_XMLFilePath_MetaData, UE_ARRAY_COUNT(Z_Construct_UClass_AIceSpawnerClass_Statics::NewProp_XMLFilePath_MetaData)) };
	const UE4CodeGen_Private::FClassPropertyParams Z_Construct_UClass_AIceSpawnerClass_Statics::NewProp_ActorsToSpawn_Inner = { "ActorsToSpawn", nullptr, (EPropertyFlags)0x0004000000000000, UE4CodeGen_Private::EPropertyGenFlags::Class, RF_Public|RF_Transient|RF_MarkAsNative, 1, 0, Z_Construct_UClass_AActor_NoRegister, Z_Construct_UClass_UClass, METADATA_PARAMS(nullptr, 0) };
#if WITH_METADATA
	const UE4CodeGen_Private::FMetaDataPairParam Z_Construct_UClass_AIceSpawnerClass_Statics::NewProp_ActorsToSpawn_MetaData[] = {
		{ "Category", "IceSpawnerClass" },
		{ "Comment", "//reference to the actor being spawned,\n// should match VisualMesh\n" },
		{ "ModuleRelativePath", "Public/IceSpawnerClass.h" },
		{ "ToolTip", "reference to the actor being spawned,\n should match VisualMesh" },
	};
#endif
	const UE4CodeGen_Private::FArrayPropertyParams Z_Construct_UClass_AIceSpawnerClass_Statics::NewProp_ActorsToSpawn = { "ActorsToSpawn", nullptr, (EPropertyFlags)0x0014000000010001, UE4CodeGen_Private::EPropertyGenFlags::Array, RF_Public|RF_Transient|RF_MarkAsNative, 1, STRUCT_OFFSET(AIceSpawnerClass, ActorsToSpawn), EArrayPropertyFlags::None, METADATA_PARAMS(Z_Construct_UClass_AIceSpawnerClass_Statics::NewProp_ActorsToSpawn_MetaData, UE_ARRAY_COUNT(Z_Construct_UClass_AIceSpawnerClass_Statics::NewProp_ActorsToSpawn_MetaData)) };
	const UE4CodeGen_Private::FObjectPropertyParams Z_Construct_UClass_AIceSpawnerClass_Statics::NewProp_VisualMeshes_Inner = { "VisualMeshes", nullptr, (EPropertyFlags)0x0000000000000000, UE4CodeGen_Private::EPropertyGenFlags::Object, RF_Public|RF_Transient|RF_MarkAsNative, 1, 0, Z_Construct_UClass_UStaticMesh_NoRegister, METADATA_PARAMS(nullptr, 0) };
#if WITH_METADATA
	const UE4CodeGen_Private::FMetaDataPairParam Z_Construct_UClass_AIceSpawnerClass_Statics::NewProp_VisualMeshes_MetaData[] = {
		{ "Category", "IceSpawnerClass" },
		{ "Comment", "// reference to the visualmesh of the actor,\n// should match ActorToSpawn\n" },
		{ "ModuleRelativePath", "Public/IceSpawnerClass.h" },
		{ "ToolTip", "reference to the visualmesh of the actor,\nshould match ActorToSpawn" },
	};
#endif
	const UE4CodeGen_Private::FArrayPropertyParams Z_Construct_UClass_AIceSpawnerClass_Statics::NewProp_VisualMeshes = { "VisualMeshes", nullptr, (EPropertyFlags)0x0010000000010001, UE4CodeGen_Private::EPropertyGenFlags::Array, RF_Public|RF_Transient|RF_MarkAsNative, 1, STRUCT_OFFSET(AIceSpawnerClass, VisualMeshes), EArrayPropertyFlags::None, METADATA_PARAMS(Z_Construct_UClass_AIceSpawnerClass_Statics::NewProp_VisualMeshes_MetaData, UE_ARRAY_COUNT(Z_Construct_UClass_AIceSpawnerClass_Statics::NewProp_VisualMeshes_MetaData)) };
#if WITH_METADATA
	const UE4CodeGen_Private::FMetaDataPairParam Z_Construct_UClass_AIceSpawnerClass_Statics::NewProp_n_MetaData[] = {
		{ "Category", "IceSpawnerClass" },
		{ "Comment", "// we end up with 2^n by 2^n number of ice structures,\n// set to -1 if you want to automatically set the number of ice structures\n" },
		{ "ModuleRelativePath", "Public/IceSpawnerClass.h" },
		{ "ToolTip", "we end up with 2^n by 2^n number of ice structures,\nset to -1 if you want to automatically set the number of ice structures" },
	};
#endif
	const UE4CodeGen_Private::FFloatPropertyParams Z_Construct_UClass_AIceSpawnerClass_Statics::NewProp_n = { "n", nullptr, (EPropertyFlags)0x0010000000010001, UE4CodeGen_Private::EPropertyGenFlags::Float, RF_Public|RF_Transient|RF_MarkAsNative, 1, STRUCT_OFFSET(AIceSpawnerClass, n), METADATA_PARAMS(Z_Construct_UClass_AIceSpawnerClass_Statics::NewProp_n_MetaData, UE_ARRAY_COUNT(Z_Construct_UClass_AIceSpawnerClass_Statics::NewProp_n_MetaData)) };
#if WITH_METADATA
	const UE4CodeGen_Private::FMetaDataPairParam Z_Construct_UClass_AIceSpawnerClass_Statics::NewProp_dimension_MetaData[] = {
		{ "Category", "IceSpawnerClass" },
		{ "Comment", "// dimension of ice in cm\n" },
		{ "ModuleRelativePath", "Public/IceSpawnerClass.h" },
		{ "ToolTip", "dimension of ice in cm" },
	};
#endif
	const UE4CodeGen_Private::FFloatPropertyParams Z_Construct_UClass_AIceSpawnerClass_Statics::NewProp_dimension = { "dimension", nullptr, (EPropertyFlags)0x0010000000010001, UE4CodeGen_Private::EPropertyGenFlags::Float, RF_Public|RF_Transient|RF_MarkAsNative, 1, STRUCT_OFFSET(AIceSpawnerClass, dimension), METADATA_PARAMS(Z_Construct_UClass_AIceSpawnerClass_Statics::NewProp_dimension_MetaData, UE_ARRAY_COUNT(Z_Construct_UClass_AIceSpawnerClass_Statics::NewProp_dimension_MetaData)) };
#if WITH_METADATA
	const UE4CodeGen_Private::FMetaDataPairParam Z_Construct_UClass_AIceSpawnerClass_Statics::NewProp_thickness_MetaData[] = {
		{ "Category", "IceSpawnerClass" },
		{ "Comment", "// thickness of ice in cm\n" },
		{ "ModuleRelativePath", "Public/IceSpawnerClass.h" },
		{ "ToolTip", "thickness of ice in cm" },
	};
#endif
	const UE4CodeGen_Private::FFloatPropertyParams Z_Construct_UClass_AIceSpawnerClass_Statics::NewProp_thickness = { "thickness", nullptr, (EPropertyFlags)0x0010000000010001, UE4CodeGen_Private::EPropertyGenFlags::Float, RF_Public|RF_Transient|RF_MarkAsNative, 1, STRUCT_OFFSET(AIceSpawnerClass, thickness), METADATA_PARAMS(Z_Construct_UClass_AIceSpawnerClass_Statics::NewProp_thickness_MetaData, UE_ARRAY_COUNT(Z_Construct_UClass_AIceSpawnerClass_Statics::NewProp_thickness_MetaData)) };
	const UE4CodeGen_Private::FPropertyParamsBase* const Z_Construct_UClass_AIceSpawnerClass_Statics::PropPointers[] = {
		(const UE4CodeGen_Private::FPropertyParamsBase*)&Z_Construct_UClass_AIceSpawnerClass_Statics::NewProp_UseXML,
		(const UE4CodeGen_Private::FPropertyParamsBase*)&Z_Construct_UClass_AIceSpawnerClass_Statics::NewProp_XMLFilePath,
		(const UE4CodeGen_Private::FPropertyParamsBase*)&Z_Construct_UClass_AIceSpawnerClass_Statics::NewProp_ActorsToSpawn_Inner,
		(const UE4CodeGen_Private::FPropertyParamsBase*)&Z_Construct_UClass_AIceSpawnerClass_Statics::NewProp_ActorsToSpawn,
		(const UE4CodeGen_Private::FPropertyParamsBase*)&Z_Construct_UClass_AIceSpawnerClass_Statics::NewProp_VisualMeshes_Inner,
		(const UE4CodeGen_Private::FPropertyParamsBase*)&Z_Construct_UClass_AIceSpawnerClass_Statics::NewProp_VisualMeshes,
		(const UE4CodeGen_Private::FPropertyParamsBase*)&Z_Construct_UClass_AIceSpawnerClass_Statics::NewProp_n,
		(const UE4CodeGen_Private::FPropertyParamsBase*)&Z_Construct_UClass_AIceSpawnerClass_Statics::NewProp_dimension,
		(const UE4CodeGen_Private::FPropertyParamsBase*)&Z_Construct_UClass_AIceSpawnerClass_Statics::NewProp_thickness,
	};
	const FCppClassTypeInfoStatic Z_Construct_UClass_AIceSpawnerClass_Statics::StaticCppClassTypeInfo = {
		TCppClassTypeTraits<AIceSpawnerClass>::IsAbstract,
	};
	const UE4CodeGen_Private::FClassParams Z_Construct_UClass_AIceSpawnerClass_Statics::ClassParams = {
		&AIceSpawnerClass::StaticClass,
		"Game",
		&StaticCppClassTypeInfo,
		DependentSingletons,
		FuncInfo,
		Z_Construct_UClass_AIceSpawnerClass_Statics::PropPointers,
		nullptr,
		UE_ARRAY_COUNT(DependentSingletons),
		UE_ARRAY_COUNT(FuncInfo),
		UE_ARRAY_COUNT(Z_Construct_UClass_AIceSpawnerClass_Statics::PropPointers),
		0,
		0x009000A4u,
		METADATA_PARAMS(Z_Construct_UClass_AIceSpawnerClass_Statics::Class_MetaDataParams, UE_ARRAY_COUNT(Z_Construct_UClass_AIceSpawnerClass_Statics::Class_MetaDataParams))
	};
	UClass* Z_Construct_UClass_AIceSpawnerClass()
	{
		static UClass* OuterClass = nullptr;
		if (!OuterClass)
		{
			UE4CodeGen_Private::ConstructUClass(OuterClass, Z_Construct_UClass_AIceSpawnerClass_Statics::ClassParams);
		}
		return OuterClass;
	}
	IMPLEMENT_CLASS(AIceSpawnerClass, 1675311248);
	template<> DRONEEXP1_API UClass* StaticClass<AIceSpawnerClass>()
	{
		return AIceSpawnerClass::StaticClass();
	}
	static FCompiledInDefer Z_CompiledInDefer_UClass_AIceSpawnerClass(Z_Construct_UClass_AIceSpawnerClass, &AIceSpawnerClass::StaticClass, TEXT("/Script/DroneExp1"), TEXT("AIceSpawnerClass"), false, nullptr, nullptr, nullptr);
	DEFINE_VTABLE_PTR_HELPER_CTOR(AIceSpawnerClass);
PRAGMA_ENABLE_DEPRECATION_WARNINGS
#ifdef _MSC_VER
#pragma warning (pop)
#endif
