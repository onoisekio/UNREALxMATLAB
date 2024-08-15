// Copyright Epic Games, Inc. All Rights Reserved.
/*===========================================================================
	Generated code exported from UnrealHeaderTool.
	DO NOT modify this manually! Edit the corresponding .h files instead!
===========================================================================*/

#include "UObject/GeneratedCppIncludes.h"
#include "DroneExp1/Public/BuoyancyPlacement.h"
#ifdef _MSC_VER
#pragma warning (push)
#pragma warning (disable : 4883)
#endif
PRAGMA_DISABLE_DEPRECATION_WARNINGS
void EmptyLinkFunctionForGeneratedCodeBuoyancyPlacement() {}
// Cross Module References
	DRONEEXP1_API UClass* Z_Construct_UClass_ABuoyancyPlacement_NoRegister();
	DRONEEXP1_API UClass* Z_Construct_UClass_ABuoyancyPlacement();
	ENGINE_API UClass* Z_Construct_UClass_AActor();
	UPackage* Z_Construct_UPackage__Script_DroneExp1();
	COREUOBJECT_API UScriptStruct* Z_Construct_UScriptStruct_FVector();
	ENGINE_API UClass* Z_Construct_UClass_UStaticMeshComponent_NoRegister();
// End Cross Module References
	DEFINE_FUNCTION(ABuoyancyPlacement::execReturnPoints)
	{
		P_GET_PROPERTY(FNameProperty,Z_Param_PontoonCenterSocket);
		P_GET_STRUCT(FVector,Z_Param_PontoonRelativeLocation);
		P_GET_PROPERTY(FFloatProperty,Z_Param_PontoonRadius);
		P_FINISH;
		P_NATIVE_BEGIN;
		P_THIS->ReturnPoints(Z_Param_PontoonCenterSocket,Z_Param_PontoonRelativeLocation,Z_Param_PontoonRadius);
		P_NATIVE_END;
	}
	void ABuoyancyPlacement::StaticRegisterNativesABuoyancyPlacement()
	{
		UClass* Class = ABuoyancyPlacement::StaticClass();
		static const FNameNativePtrPair Funcs[] = {
			{ "ReturnPoints", &ABuoyancyPlacement::execReturnPoints },
		};
		FNativeFunctionRegistrar::RegisterFunctions(Class, Funcs, UE_ARRAY_COUNT(Funcs));
	}
	struct Z_Construct_UFunction_ABuoyancyPlacement_ReturnPoints_Statics
	{
		struct BuoyancyPlacement_eventReturnPoints_Parms
		{
			FName PontoonCenterSocket;
			FVector PontoonRelativeLocation;
			float PontoonRadius;
		};
		static const UE4CodeGen_Private::FNamePropertyParams NewProp_PontoonCenterSocket;
		static const UE4CodeGen_Private::FStructPropertyParams NewProp_PontoonRelativeLocation;
		static const UE4CodeGen_Private::FFloatPropertyParams NewProp_PontoonRadius;
		static const UE4CodeGen_Private::FPropertyParamsBase* const PropPointers[];
#if WITH_METADATA
		static const UE4CodeGen_Private::FMetaDataPairParam Function_MetaDataParams[];
#endif
		static const UE4CodeGen_Private::FFunctionParams FuncParams;
	};
	const UE4CodeGen_Private::FNamePropertyParams Z_Construct_UFunction_ABuoyancyPlacement_ReturnPoints_Statics::NewProp_PontoonCenterSocket = { "PontoonCenterSocket", nullptr, (EPropertyFlags)0x0010000000000080, UE4CodeGen_Private::EPropertyGenFlags::Name, RF_Public|RF_Transient|RF_MarkAsNative, 1, STRUCT_OFFSET(BuoyancyPlacement_eventReturnPoints_Parms, PontoonCenterSocket), METADATA_PARAMS(nullptr, 0) };
	const UE4CodeGen_Private::FStructPropertyParams Z_Construct_UFunction_ABuoyancyPlacement_ReturnPoints_Statics::NewProp_PontoonRelativeLocation = { "PontoonRelativeLocation", nullptr, (EPropertyFlags)0x0010000000000080, UE4CodeGen_Private::EPropertyGenFlags::Struct, RF_Public|RF_Transient|RF_MarkAsNative, 1, STRUCT_OFFSET(BuoyancyPlacement_eventReturnPoints_Parms, PontoonRelativeLocation), Z_Construct_UScriptStruct_FVector, METADATA_PARAMS(nullptr, 0) };
	const UE4CodeGen_Private::FFloatPropertyParams Z_Construct_UFunction_ABuoyancyPlacement_ReturnPoints_Statics::NewProp_PontoonRadius = { "PontoonRadius", nullptr, (EPropertyFlags)0x0010000000000080, UE4CodeGen_Private::EPropertyGenFlags::Float, RF_Public|RF_Transient|RF_MarkAsNative, 1, STRUCT_OFFSET(BuoyancyPlacement_eventReturnPoints_Parms, PontoonRadius), METADATA_PARAMS(nullptr, 0) };
	const UE4CodeGen_Private::FPropertyParamsBase* const Z_Construct_UFunction_ABuoyancyPlacement_ReturnPoints_Statics::PropPointers[] = {
		(const UE4CodeGen_Private::FPropertyParamsBase*)&Z_Construct_UFunction_ABuoyancyPlacement_ReturnPoints_Statics::NewProp_PontoonCenterSocket,
		(const UE4CodeGen_Private::FPropertyParamsBase*)&Z_Construct_UFunction_ABuoyancyPlacement_ReturnPoints_Statics::NewProp_PontoonRelativeLocation,
		(const UE4CodeGen_Private::FPropertyParamsBase*)&Z_Construct_UFunction_ABuoyancyPlacement_ReturnPoints_Statics::NewProp_PontoonRadius,
	};
#if WITH_METADATA
	const UE4CodeGen_Private::FMetaDataPairParam Z_Construct_UFunction_ABuoyancyPlacement_ReturnPoints_Statics::Function_MetaDataParams[] = {
		{ "Category", "Socket" },
		{ "ModuleRelativePath", "Public/BuoyancyPlacement.h" },
	};
#endif
	const UE4CodeGen_Private::FFunctionParams Z_Construct_UFunction_ABuoyancyPlacement_ReturnPoints_Statics::FuncParams = { (UObject*(*)())Z_Construct_UClass_ABuoyancyPlacement, nullptr, "ReturnPoints", nullptr, nullptr, sizeof(BuoyancyPlacement_eventReturnPoints_Parms), Z_Construct_UFunction_ABuoyancyPlacement_ReturnPoints_Statics::PropPointers, UE_ARRAY_COUNT(Z_Construct_UFunction_ABuoyancyPlacement_ReturnPoints_Statics::PropPointers), RF_Public|RF_Transient|RF_MarkAsNative, (EFunctionFlags)0x04820401, 0, 0, METADATA_PARAMS(Z_Construct_UFunction_ABuoyancyPlacement_ReturnPoints_Statics::Function_MetaDataParams, UE_ARRAY_COUNT(Z_Construct_UFunction_ABuoyancyPlacement_ReturnPoints_Statics::Function_MetaDataParams)) };
	UFunction* Z_Construct_UFunction_ABuoyancyPlacement_ReturnPoints()
	{
		static UFunction* ReturnFunction = nullptr;
		if (!ReturnFunction)
		{
			UE4CodeGen_Private::ConstructUFunction(ReturnFunction, Z_Construct_UFunction_ABuoyancyPlacement_ReturnPoints_Statics::FuncParams);
		}
		return ReturnFunction;
	}
	UClass* Z_Construct_UClass_ABuoyancyPlacement_NoRegister()
	{
		return ABuoyancyPlacement::StaticClass();
	}
	struct Z_Construct_UClass_ABuoyancyPlacement_Statics
	{
		static UObject* (*const DependentSingletons[])();
		static const FClassFunctionLinkInfo FuncInfo[];
#if WITH_METADATA
		static const UE4CodeGen_Private::FMetaDataPairParam Class_MetaDataParams[];
#endif
#if WITH_METADATA
		static const UE4CodeGen_Private::FMetaDataPairParam NewProp_SocketCount_MetaData[];
#endif
		static const UE4CodeGen_Private::FIntPropertyParams NewProp_SocketCount;
#if WITH_METADATA
		static const UE4CodeGen_Private::FMetaDataPairParam NewProp_VisualMesh_MetaData[];
#endif
		static const UE4CodeGen_Private::FObjectPropertyParams NewProp_VisualMesh;
		static const UE4CodeGen_Private::FPropertyParamsBase* const PropPointers[];
		static const FCppClassTypeInfoStatic StaticCppClassTypeInfo;
		static const UE4CodeGen_Private::FClassParams ClassParams;
	};
	UObject* (*const Z_Construct_UClass_ABuoyancyPlacement_Statics::DependentSingletons[])() = {
		(UObject* (*)())Z_Construct_UClass_AActor,
		(UObject* (*)())Z_Construct_UPackage__Script_DroneExp1,
	};
	const FClassFunctionLinkInfo Z_Construct_UClass_ABuoyancyPlacement_Statics::FuncInfo[] = {
		{ &Z_Construct_UFunction_ABuoyancyPlacement_ReturnPoints, "ReturnPoints" }, // 593439980
	};
#if WITH_METADATA
	const UE4CodeGen_Private::FMetaDataPairParam Z_Construct_UClass_ABuoyancyPlacement_Statics::Class_MetaDataParams[] = {
		{ "IncludePath", "BuoyancyPlacement.h" },
		{ "ModuleRelativePath", "Public/BuoyancyPlacement.h" },
	};
#endif
#if WITH_METADATA
	const UE4CodeGen_Private::FMetaDataPairParam Z_Construct_UClass_ABuoyancyPlacement_Statics::NewProp_SocketCount_MetaData[] = {
		{ "Category", "Socket" },
		{ "Comment", "// Sets default values for this actor's properties\n" },
		{ "ModuleRelativePath", "Public/BuoyancyPlacement.h" },
		{ "ToolTip", "Sets default values for this actor's properties" },
	};
#endif
	const UE4CodeGen_Private::FIntPropertyParams Z_Construct_UClass_ABuoyancyPlacement_Statics::NewProp_SocketCount = { "SocketCount", nullptr, (EPropertyFlags)0x0010000000000005, UE4CodeGen_Private::EPropertyGenFlags::Int, RF_Public|RF_Transient|RF_MarkAsNative, 1, STRUCT_OFFSET(ABuoyancyPlacement, SocketCount), METADATA_PARAMS(Z_Construct_UClass_ABuoyancyPlacement_Statics::NewProp_SocketCount_MetaData, UE_ARRAY_COUNT(Z_Construct_UClass_ABuoyancyPlacement_Statics::NewProp_SocketCount_MetaData)) };
#if WITH_METADATA
	const UE4CodeGen_Private::FMetaDataPairParam Z_Construct_UClass_ABuoyancyPlacement_Statics::NewProp_VisualMesh_MetaData[] = {
		{ "Category", "BuoyancyPlacement" },
		{ "EditInline", "true" },
		{ "ModuleRelativePath", "Public/BuoyancyPlacement.h" },
	};
#endif
	const UE4CodeGen_Private::FObjectPropertyParams Z_Construct_UClass_ABuoyancyPlacement_Statics::NewProp_VisualMesh = { "VisualMesh", nullptr, (EPropertyFlags)0x00100000000a0009, UE4CodeGen_Private::EPropertyGenFlags::Object, RF_Public|RF_Transient|RF_MarkAsNative, 1, STRUCT_OFFSET(ABuoyancyPlacement, VisualMesh), Z_Construct_UClass_UStaticMeshComponent_NoRegister, METADATA_PARAMS(Z_Construct_UClass_ABuoyancyPlacement_Statics::NewProp_VisualMesh_MetaData, UE_ARRAY_COUNT(Z_Construct_UClass_ABuoyancyPlacement_Statics::NewProp_VisualMesh_MetaData)) };
	const UE4CodeGen_Private::FPropertyParamsBase* const Z_Construct_UClass_ABuoyancyPlacement_Statics::PropPointers[] = {
		(const UE4CodeGen_Private::FPropertyParamsBase*)&Z_Construct_UClass_ABuoyancyPlacement_Statics::NewProp_SocketCount,
		(const UE4CodeGen_Private::FPropertyParamsBase*)&Z_Construct_UClass_ABuoyancyPlacement_Statics::NewProp_VisualMesh,
	};
	const FCppClassTypeInfoStatic Z_Construct_UClass_ABuoyancyPlacement_Statics::StaticCppClassTypeInfo = {
		TCppClassTypeTraits<ABuoyancyPlacement>::IsAbstract,
	};
	const UE4CodeGen_Private::FClassParams Z_Construct_UClass_ABuoyancyPlacement_Statics::ClassParams = {
		&ABuoyancyPlacement::StaticClass,
		"Engine",
		&StaticCppClassTypeInfo,
		DependentSingletons,
		FuncInfo,
		Z_Construct_UClass_ABuoyancyPlacement_Statics::PropPointers,
		nullptr,
		UE_ARRAY_COUNT(DependentSingletons),
		UE_ARRAY_COUNT(FuncInfo),
		UE_ARRAY_COUNT(Z_Construct_UClass_ABuoyancyPlacement_Statics::PropPointers),
		0,
		0x009000A4u,
		METADATA_PARAMS(Z_Construct_UClass_ABuoyancyPlacement_Statics::Class_MetaDataParams, UE_ARRAY_COUNT(Z_Construct_UClass_ABuoyancyPlacement_Statics::Class_MetaDataParams))
	};
	UClass* Z_Construct_UClass_ABuoyancyPlacement()
	{
		static UClass* OuterClass = nullptr;
		if (!OuterClass)
		{
			UE4CodeGen_Private::ConstructUClass(OuterClass, Z_Construct_UClass_ABuoyancyPlacement_Statics::ClassParams);
		}
		return OuterClass;
	}
	IMPLEMENT_CLASS(ABuoyancyPlacement, 1033533204);
	template<> DRONEEXP1_API UClass* StaticClass<ABuoyancyPlacement>()
	{
		return ABuoyancyPlacement::StaticClass();
	}
	static FCompiledInDefer Z_CompiledInDefer_UClass_ABuoyancyPlacement(Z_Construct_UClass_ABuoyancyPlacement, &ABuoyancyPlacement::StaticClass, TEXT("/Script/DroneExp1"), TEXT("ABuoyancyPlacement"), false, nullptr, nullptr, nullptr);
	DEFINE_VTABLE_PTR_HELPER_CTOR(ABuoyancyPlacement);
PRAGMA_ENABLE_DEPRECATION_WARNINGS
#ifdef _MSC_VER
#pragma warning (pop)
#endif
