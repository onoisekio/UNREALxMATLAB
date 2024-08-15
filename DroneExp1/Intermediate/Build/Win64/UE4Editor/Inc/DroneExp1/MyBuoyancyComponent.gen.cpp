// Copyright Epic Games, Inc. All Rights Reserved.
/*===========================================================================
	Generated code exported from UnrealHeaderTool.
	DO NOT modify this manually! Edit the corresponding .h files instead!
===========================================================================*/

#include "UObject/GeneratedCppIncludes.h"
#include "DroneExp1/Public/MyBuoyancyComponent.h"
#ifdef _MSC_VER
#pragma warning (push)
#pragma warning (disable : 4883)
#endif
PRAGMA_DISABLE_DEPRECATION_WARNINGS
void EmptyLinkFunctionForGeneratedCodeMyBuoyancyComponent() {}
// Cross Module References
	DRONEEXP1_API UClass* Z_Construct_UClass_UMyBuoyancyComponent_NoRegister();
	DRONEEXP1_API UClass* Z_Construct_UClass_UMyBuoyancyComponent();
	WATER_API UClass* Z_Construct_UClass_UBuoyancyComponent();
	UPackage* Z_Construct_UPackage__Script_DroneExp1();
	COREUOBJECT_API UScriptStruct* Z_Construct_UScriptStruct_FVector();
	ENGINE_API UClass* Z_Construct_UClass_UStaticMeshComponent_NoRegister();
// End Cross Module References
	DEFINE_FUNCTION(UMyBuoyancyComponent::execPresetPhysics)
	{
		P_GET_OBJECT(UStaticMeshComponent,Z_Param_VisualMesh);
		P_FINISH;
		P_NATIVE_BEGIN;
		P_THIS->PresetPhysics(Z_Param_VisualMesh);
		P_NATIVE_END;
	}
	DEFINE_FUNCTION(UMyBuoyancyComponent::execPresetBuoyancy)
	{
		P_GET_OBJECT(UStaticMeshComponent,Z_Param_VisualMesh);
		P_FINISH;
		P_NATIVE_BEGIN;
		P_THIS->PresetBuoyancy(Z_Param_VisualMesh);
		P_NATIVE_END;
	}
	DEFINE_FUNCTION(UMyBuoyancyComponent::execAddPontoon)
	{
		P_GET_STRUCT(FVector,Z_Param_RelativeLocation);
		P_GET_PROPERTY(FFloatProperty,Z_Param_Radius);
		P_FINISH;
		P_NATIVE_BEGIN;
		*(int32*)Z_Param__Result=P_THIS->AddPontoon(Z_Param_RelativeLocation,Z_Param_Radius);
		P_NATIVE_END;
	}
	DEFINE_FUNCTION(UMyBuoyancyComponent::execAddPontoons)
	{
		P_GET_OBJECT(UStaticMeshComponent,Z_Param_VisualMesh);
		P_FINISH;
		P_NATIVE_BEGIN;
		*(int32*)Z_Param__Result=P_THIS->AddPontoons(Z_Param_VisualMesh);
		P_NATIVE_END;
	}
	void UMyBuoyancyComponent::StaticRegisterNativesUMyBuoyancyComponent()
	{
		UClass* Class = UMyBuoyancyComponent::StaticClass();
		static const FNameNativePtrPair Funcs[] = {
			{ "AddPontoon", &UMyBuoyancyComponent::execAddPontoon },
			{ "AddPontoons", &UMyBuoyancyComponent::execAddPontoons },
			{ "PresetBuoyancy", &UMyBuoyancyComponent::execPresetBuoyancy },
			{ "PresetPhysics", &UMyBuoyancyComponent::execPresetPhysics },
		};
		FNativeFunctionRegistrar::RegisterFunctions(Class, Funcs, UE_ARRAY_COUNT(Funcs));
	}
	struct Z_Construct_UFunction_UMyBuoyancyComponent_AddPontoon_Statics
	{
		struct MyBuoyancyComponent_eventAddPontoon_Parms
		{
			FVector RelativeLocation;
			float Radius;
			int32 ReturnValue;
		};
		static const UE4CodeGen_Private::FStructPropertyParams NewProp_RelativeLocation;
		static const UE4CodeGen_Private::FFloatPropertyParams NewProp_Radius;
		static const UE4CodeGen_Private::FIntPropertyParams NewProp_ReturnValue;
		static const UE4CodeGen_Private::FPropertyParamsBase* const PropPointers[];
#if WITH_METADATA
		static const UE4CodeGen_Private::FMetaDataPairParam Function_MetaDataParams[];
#endif
		static const UE4CodeGen_Private::FFunctionParams FuncParams;
	};
	const UE4CodeGen_Private::FStructPropertyParams Z_Construct_UFunction_UMyBuoyancyComponent_AddPontoon_Statics::NewProp_RelativeLocation = { "RelativeLocation", nullptr, (EPropertyFlags)0x0010000000000080, UE4CodeGen_Private::EPropertyGenFlags::Struct, RF_Public|RF_Transient|RF_MarkAsNative, 1, STRUCT_OFFSET(MyBuoyancyComponent_eventAddPontoon_Parms, RelativeLocation), Z_Construct_UScriptStruct_FVector, METADATA_PARAMS(nullptr, 0) };
	const UE4CodeGen_Private::FFloatPropertyParams Z_Construct_UFunction_UMyBuoyancyComponent_AddPontoon_Statics::NewProp_Radius = { "Radius", nullptr, (EPropertyFlags)0x0010000000000080, UE4CodeGen_Private::EPropertyGenFlags::Float, RF_Public|RF_Transient|RF_MarkAsNative, 1, STRUCT_OFFSET(MyBuoyancyComponent_eventAddPontoon_Parms, Radius), METADATA_PARAMS(nullptr, 0) };
	const UE4CodeGen_Private::FIntPropertyParams Z_Construct_UFunction_UMyBuoyancyComponent_AddPontoon_Statics::NewProp_ReturnValue = { "ReturnValue", nullptr, (EPropertyFlags)0x0010000000000580, UE4CodeGen_Private::EPropertyGenFlags::Int, RF_Public|RF_Transient|RF_MarkAsNative, 1, STRUCT_OFFSET(MyBuoyancyComponent_eventAddPontoon_Parms, ReturnValue), METADATA_PARAMS(nullptr, 0) };
	const UE4CodeGen_Private::FPropertyParamsBase* const Z_Construct_UFunction_UMyBuoyancyComponent_AddPontoon_Statics::PropPointers[] = {
		(const UE4CodeGen_Private::FPropertyParamsBase*)&Z_Construct_UFunction_UMyBuoyancyComponent_AddPontoon_Statics::NewProp_RelativeLocation,
		(const UE4CodeGen_Private::FPropertyParamsBase*)&Z_Construct_UFunction_UMyBuoyancyComponent_AddPontoon_Statics::NewProp_Radius,
		(const UE4CodeGen_Private::FPropertyParamsBase*)&Z_Construct_UFunction_UMyBuoyancyComponent_AddPontoon_Statics::NewProp_ReturnValue,
	};
#if WITH_METADATA
	const UE4CodeGen_Private::FMetaDataPairParam Z_Construct_UFunction_UMyBuoyancyComponent_AddPontoon_Statics::Function_MetaDataParams[] = {
		{ "Category", "Buoyancy" },
		{ "ModuleRelativePath", "Public/MyBuoyancyComponent.h" },
	};
#endif
	const UE4CodeGen_Private::FFunctionParams Z_Construct_UFunction_UMyBuoyancyComponent_AddPontoon_Statics::FuncParams = { (UObject*(*)())Z_Construct_UClass_UMyBuoyancyComponent, nullptr, "AddPontoon", nullptr, nullptr, sizeof(MyBuoyancyComponent_eventAddPontoon_Parms), Z_Construct_UFunction_UMyBuoyancyComponent_AddPontoon_Statics::PropPointers, UE_ARRAY_COUNT(Z_Construct_UFunction_UMyBuoyancyComponent_AddPontoon_Statics::PropPointers), RF_Public|RF_Transient|RF_MarkAsNative, (EFunctionFlags)0x04820401, 0, 0, METADATA_PARAMS(Z_Construct_UFunction_UMyBuoyancyComponent_AddPontoon_Statics::Function_MetaDataParams, UE_ARRAY_COUNT(Z_Construct_UFunction_UMyBuoyancyComponent_AddPontoon_Statics::Function_MetaDataParams)) };
	UFunction* Z_Construct_UFunction_UMyBuoyancyComponent_AddPontoon()
	{
		static UFunction* ReturnFunction = nullptr;
		if (!ReturnFunction)
		{
			UE4CodeGen_Private::ConstructUFunction(ReturnFunction, Z_Construct_UFunction_UMyBuoyancyComponent_AddPontoon_Statics::FuncParams);
		}
		return ReturnFunction;
	}
	struct Z_Construct_UFunction_UMyBuoyancyComponent_AddPontoons_Statics
	{
		struct MyBuoyancyComponent_eventAddPontoons_Parms
		{
			UStaticMeshComponent* VisualMesh;
			int32 ReturnValue;
		};
#if WITH_METADATA
		static const UE4CodeGen_Private::FMetaDataPairParam NewProp_VisualMesh_MetaData[];
#endif
		static const UE4CodeGen_Private::FObjectPropertyParams NewProp_VisualMesh;
		static const UE4CodeGen_Private::FIntPropertyParams NewProp_ReturnValue;
		static const UE4CodeGen_Private::FPropertyParamsBase* const PropPointers[];
#if WITH_METADATA
		static const UE4CodeGen_Private::FMetaDataPairParam Function_MetaDataParams[];
#endif
		static const UE4CodeGen_Private::FFunctionParams FuncParams;
	};
#if WITH_METADATA
	const UE4CodeGen_Private::FMetaDataPairParam Z_Construct_UFunction_UMyBuoyancyComponent_AddPontoons_Statics::NewProp_VisualMesh_MetaData[] = {
		{ "EditInline", "true" },
	};
#endif
	const UE4CodeGen_Private::FObjectPropertyParams Z_Construct_UFunction_UMyBuoyancyComponent_AddPontoons_Statics::NewProp_VisualMesh = { "VisualMesh", nullptr, (EPropertyFlags)0x0010000000080080, UE4CodeGen_Private::EPropertyGenFlags::Object, RF_Public|RF_Transient|RF_MarkAsNative, 1, STRUCT_OFFSET(MyBuoyancyComponent_eventAddPontoons_Parms, VisualMesh), Z_Construct_UClass_UStaticMeshComponent_NoRegister, METADATA_PARAMS(Z_Construct_UFunction_UMyBuoyancyComponent_AddPontoons_Statics::NewProp_VisualMesh_MetaData, UE_ARRAY_COUNT(Z_Construct_UFunction_UMyBuoyancyComponent_AddPontoons_Statics::NewProp_VisualMesh_MetaData)) };
	const UE4CodeGen_Private::FIntPropertyParams Z_Construct_UFunction_UMyBuoyancyComponent_AddPontoons_Statics::NewProp_ReturnValue = { "ReturnValue", nullptr, (EPropertyFlags)0x0010000000000580, UE4CodeGen_Private::EPropertyGenFlags::Int, RF_Public|RF_Transient|RF_MarkAsNative, 1, STRUCT_OFFSET(MyBuoyancyComponent_eventAddPontoons_Parms, ReturnValue), METADATA_PARAMS(nullptr, 0) };
	const UE4CodeGen_Private::FPropertyParamsBase* const Z_Construct_UFunction_UMyBuoyancyComponent_AddPontoons_Statics::PropPointers[] = {
		(const UE4CodeGen_Private::FPropertyParamsBase*)&Z_Construct_UFunction_UMyBuoyancyComponent_AddPontoons_Statics::NewProp_VisualMesh,
		(const UE4CodeGen_Private::FPropertyParamsBase*)&Z_Construct_UFunction_UMyBuoyancyComponent_AddPontoons_Statics::NewProp_ReturnValue,
	};
#if WITH_METADATA
	const UE4CodeGen_Private::FMetaDataPairParam Z_Construct_UFunction_UMyBuoyancyComponent_AddPontoons_Statics::Function_MetaDataParams[] = {
		{ "Category", "Buoyancy" },
		{ "ModuleRelativePath", "Public/MyBuoyancyComponent.h" },
	};
#endif
	const UE4CodeGen_Private::FFunctionParams Z_Construct_UFunction_UMyBuoyancyComponent_AddPontoons_Statics::FuncParams = { (UObject*(*)())Z_Construct_UClass_UMyBuoyancyComponent, nullptr, "AddPontoons", nullptr, nullptr, sizeof(MyBuoyancyComponent_eventAddPontoons_Parms), Z_Construct_UFunction_UMyBuoyancyComponent_AddPontoons_Statics::PropPointers, UE_ARRAY_COUNT(Z_Construct_UFunction_UMyBuoyancyComponent_AddPontoons_Statics::PropPointers), RF_Public|RF_Transient|RF_MarkAsNative, (EFunctionFlags)0x04020401, 0, 0, METADATA_PARAMS(Z_Construct_UFunction_UMyBuoyancyComponent_AddPontoons_Statics::Function_MetaDataParams, UE_ARRAY_COUNT(Z_Construct_UFunction_UMyBuoyancyComponent_AddPontoons_Statics::Function_MetaDataParams)) };
	UFunction* Z_Construct_UFunction_UMyBuoyancyComponent_AddPontoons()
	{
		static UFunction* ReturnFunction = nullptr;
		if (!ReturnFunction)
		{
			UE4CodeGen_Private::ConstructUFunction(ReturnFunction, Z_Construct_UFunction_UMyBuoyancyComponent_AddPontoons_Statics::FuncParams);
		}
		return ReturnFunction;
	}
	struct Z_Construct_UFunction_UMyBuoyancyComponent_PresetBuoyancy_Statics
	{
		struct MyBuoyancyComponent_eventPresetBuoyancy_Parms
		{
			UStaticMeshComponent* VisualMesh;
		};
#if WITH_METADATA
		static const UE4CodeGen_Private::FMetaDataPairParam NewProp_VisualMesh_MetaData[];
#endif
		static const UE4CodeGen_Private::FObjectPropertyParams NewProp_VisualMesh;
		static const UE4CodeGen_Private::FPropertyParamsBase* const PropPointers[];
#if WITH_METADATA
		static const UE4CodeGen_Private::FMetaDataPairParam Function_MetaDataParams[];
#endif
		static const UE4CodeGen_Private::FFunctionParams FuncParams;
	};
#if WITH_METADATA
	const UE4CodeGen_Private::FMetaDataPairParam Z_Construct_UFunction_UMyBuoyancyComponent_PresetBuoyancy_Statics::NewProp_VisualMesh_MetaData[] = {
		{ "EditInline", "true" },
	};
#endif
	const UE4CodeGen_Private::FObjectPropertyParams Z_Construct_UFunction_UMyBuoyancyComponent_PresetBuoyancy_Statics::NewProp_VisualMesh = { "VisualMesh", nullptr, (EPropertyFlags)0x0010000000080080, UE4CodeGen_Private::EPropertyGenFlags::Object, RF_Public|RF_Transient|RF_MarkAsNative, 1, STRUCT_OFFSET(MyBuoyancyComponent_eventPresetBuoyancy_Parms, VisualMesh), Z_Construct_UClass_UStaticMeshComponent_NoRegister, METADATA_PARAMS(Z_Construct_UFunction_UMyBuoyancyComponent_PresetBuoyancy_Statics::NewProp_VisualMesh_MetaData, UE_ARRAY_COUNT(Z_Construct_UFunction_UMyBuoyancyComponent_PresetBuoyancy_Statics::NewProp_VisualMesh_MetaData)) };
	const UE4CodeGen_Private::FPropertyParamsBase* const Z_Construct_UFunction_UMyBuoyancyComponent_PresetBuoyancy_Statics::PropPointers[] = {
		(const UE4CodeGen_Private::FPropertyParamsBase*)&Z_Construct_UFunction_UMyBuoyancyComponent_PresetBuoyancy_Statics::NewProp_VisualMesh,
	};
#if WITH_METADATA
	const UE4CodeGen_Private::FMetaDataPairParam Z_Construct_UFunction_UMyBuoyancyComponent_PresetBuoyancy_Statics::Function_MetaDataParams[] = {
		{ "Category", "Buoyancy" },
		{ "ModuleRelativePath", "Public/MyBuoyancyComponent.h" },
	};
#endif
	const UE4CodeGen_Private::FFunctionParams Z_Construct_UFunction_UMyBuoyancyComponent_PresetBuoyancy_Statics::FuncParams = { (UObject*(*)())Z_Construct_UClass_UMyBuoyancyComponent, nullptr, "PresetBuoyancy", nullptr, nullptr, sizeof(MyBuoyancyComponent_eventPresetBuoyancy_Parms), Z_Construct_UFunction_UMyBuoyancyComponent_PresetBuoyancy_Statics::PropPointers, UE_ARRAY_COUNT(Z_Construct_UFunction_UMyBuoyancyComponent_PresetBuoyancy_Statics::PropPointers), RF_Public|RF_Transient|RF_MarkAsNative, (EFunctionFlags)0x04020401, 0, 0, METADATA_PARAMS(Z_Construct_UFunction_UMyBuoyancyComponent_PresetBuoyancy_Statics::Function_MetaDataParams, UE_ARRAY_COUNT(Z_Construct_UFunction_UMyBuoyancyComponent_PresetBuoyancy_Statics::Function_MetaDataParams)) };
	UFunction* Z_Construct_UFunction_UMyBuoyancyComponent_PresetBuoyancy()
	{
		static UFunction* ReturnFunction = nullptr;
		if (!ReturnFunction)
		{
			UE4CodeGen_Private::ConstructUFunction(ReturnFunction, Z_Construct_UFunction_UMyBuoyancyComponent_PresetBuoyancy_Statics::FuncParams);
		}
		return ReturnFunction;
	}
	struct Z_Construct_UFunction_UMyBuoyancyComponent_PresetPhysics_Statics
	{
		struct MyBuoyancyComponent_eventPresetPhysics_Parms
		{
			UStaticMeshComponent* VisualMesh;
		};
#if WITH_METADATA
		static const UE4CodeGen_Private::FMetaDataPairParam NewProp_VisualMesh_MetaData[];
#endif
		static const UE4CodeGen_Private::FObjectPropertyParams NewProp_VisualMesh;
		static const UE4CodeGen_Private::FPropertyParamsBase* const PropPointers[];
#if WITH_METADATA
		static const UE4CodeGen_Private::FMetaDataPairParam Function_MetaDataParams[];
#endif
		static const UE4CodeGen_Private::FFunctionParams FuncParams;
	};
#if WITH_METADATA
	const UE4CodeGen_Private::FMetaDataPairParam Z_Construct_UFunction_UMyBuoyancyComponent_PresetPhysics_Statics::NewProp_VisualMesh_MetaData[] = {
		{ "EditInline", "true" },
	};
#endif
	const UE4CodeGen_Private::FObjectPropertyParams Z_Construct_UFunction_UMyBuoyancyComponent_PresetPhysics_Statics::NewProp_VisualMesh = { "VisualMesh", nullptr, (EPropertyFlags)0x0010000000080080, UE4CodeGen_Private::EPropertyGenFlags::Object, RF_Public|RF_Transient|RF_MarkAsNative, 1, STRUCT_OFFSET(MyBuoyancyComponent_eventPresetPhysics_Parms, VisualMesh), Z_Construct_UClass_UStaticMeshComponent_NoRegister, METADATA_PARAMS(Z_Construct_UFunction_UMyBuoyancyComponent_PresetPhysics_Statics::NewProp_VisualMesh_MetaData, UE_ARRAY_COUNT(Z_Construct_UFunction_UMyBuoyancyComponent_PresetPhysics_Statics::NewProp_VisualMesh_MetaData)) };
	const UE4CodeGen_Private::FPropertyParamsBase* const Z_Construct_UFunction_UMyBuoyancyComponent_PresetPhysics_Statics::PropPointers[] = {
		(const UE4CodeGen_Private::FPropertyParamsBase*)&Z_Construct_UFunction_UMyBuoyancyComponent_PresetPhysics_Statics::NewProp_VisualMesh,
	};
#if WITH_METADATA
	const UE4CodeGen_Private::FMetaDataPairParam Z_Construct_UFunction_UMyBuoyancyComponent_PresetPhysics_Statics::Function_MetaDataParams[] = {
		{ "Category", "Buoyancy" },
		{ "ModuleRelativePath", "Public/MyBuoyancyComponent.h" },
	};
#endif
	const UE4CodeGen_Private::FFunctionParams Z_Construct_UFunction_UMyBuoyancyComponent_PresetPhysics_Statics::FuncParams = { (UObject*(*)())Z_Construct_UClass_UMyBuoyancyComponent, nullptr, "PresetPhysics", nullptr, nullptr, sizeof(MyBuoyancyComponent_eventPresetPhysics_Parms), Z_Construct_UFunction_UMyBuoyancyComponent_PresetPhysics_Statics::PropPointers, UE_ARRAY_COUNT(Z_Construct_UFunction_UMyBuoyancyComponent_PresetPhysics_Statics::PropPointers), RF_Public|RF_Transient|RF_MarkAsNative, (EFunctionFlags)0x04020401, 0, 0, METADATA_PARAMS(Z_Construct_UFunction_UMyBuoyancyComponent_PresetPhysics_Statics::Function_MetaDataParams, UE_ARRAY_COUNT(Z_Construct_UFunction_UMyBuoyancyComponent_PresetPhysics_Statics::Function_MetaDataParams)) };
	UFunction* Z_Construct_UFunction_UMyBuoyancyComponent_PresetPhysics()
	{
		static UFunction* ReturnFunction = nullptr;
		if (!ReturnFunction)
		{
			UE4CodeGen_Private::ConstructUFunction(ReturnFunction, Z_Construct_UFunction_UMyBuoyancyComponent_PresetPhysics_Statics::FuncParams);
		}
		return ReturnFunction;
	}
	UClass* Z_Construct_UClass_UMyBuoyancyComponent_NoRegister()
	{
		return UMyBuoyancyComponent::StaticClass();
	}
	struct Z_Construct_UClass_UMyBuoyancyComponent_Statics
	{
		static UObject* (*const DependentSingletons[])();
		static const FClassFunctionLinkInfo FuncInfo[];
#if WITH_METADATA
		static const UE4CodeGen_Private::FMetaDataPairParam Class_MetaDataParams[];
#endif
		static const FCppClassTypeInfoStatic StaticCppClassTypeInfo;
		static const UE4CodeGen_Private::FClassParams ClassParams;
	};
	UObject* (*const Z_Construct_UClass_UMyBuoyancyComponent_Statics::DependentSingletons[])() = {
		(UObject* (*)())Z_Construct_UClass_UBuoyancyComponent,
		(UObject* (*)())Z_Construct_UPackage__Script_DroneExp1,
	};
	const FClassFunctionLinkInfo Z_Construct_UClass_UMyBuoyancyComponent_Statics::FuncInfo[] = {
		{ &Z_Construct_UFunction_UMyBuoyancyComponent_AddPontoon, "AddPontoon" }, // 1291621950
		{ &Z_Construct_UFunction_UMyBuoyancyComponent_AddPontoons, "AddPontoons" }, // 3488127646
		{ &Z_Construct_UFunction_UMyBuoyancyComponent_PresetBuoyancy, "PresetBuoyancy" }, // 4281180013
		{ &Z_Construct_UFunction_UMyBuoyancyComponent_PresetPhysics, "PresetPhysics" }, // 494791197
	};
#if WITH_METADATA
	const UE4CodeGen_Private::FMetaDataPairParam Z_Construct_UClass_UMyBuoyancyComponent_Statics::Class_MetaDataParams[] = {
		{ "BlueprintSpawnableComponent", "" },
		{ "BlueprintType", "true" },
		{ "IncludePath", "MyBuoyancyComponent.h" },
		{ "IsBlueprintBase", "true" },
		{ "ModuleRelativePath", "Public/MyBuoyancyComponent.h" },
	};
#endif
	const FCppClassTypeInfoStatic Z_Construct_UClass_UMyBuoyancyComponent_Statics::StaticCppClassTypeInfo = {
		TCppClassTypeTraits<UMyBuoyancyComponent>::IsAbstract,
	};
	const UE4CodeGen_Private::FClassParams Z_Construct_UClass_UMyBuoyancyComponent_Statics::ClassParams = {
		&UMyBuoyancyComponent::StaticClass,
		"Game",
		&StaticCppClassTypeInfo,
		DependentSingletons,
		FuncInfo,
		nullptr,
		nullptr,
		UE_ARRAY_COUNT(DependentSingletons),
		UE_ARRAY_COUNT(FuncInfo),
		0,
		0,
		0x00B000A4u,
		METADATA_PARAMS(Z_Construct_UClass_UMyBuoyancyComponent_Statics::Class_MetaDataParams, UE_ARRAY_COUNT(Z_Construct_UClass_UMyBuoyancyComponent_Statics::Class_MetaDataParams))
	};
	UClass* Z_Construct_UClass_UMyBuoyancyComponent()
	{
		static UClass* OuterClass = nullptr;
		if (!OuterClass)
		{
			UE4CodeGen_Private::ConstructUClass(OuterClass, Z_Construct_UClass_UMyBuoyancyComponent_Statics::ClassParams);
		}
		return OuterClass;
	}
	IMPLEMENT_CLASS(UMyBuoyancyComponent, 1015565718);
	template<> DRONEEXP1_API UClass* StaticClass<UMyBuoyancyComponent>()
	{
		return UMyBuoyancyComponent::StaticClass();
	}
	static FCompiledInDefer Z_CompiledInDefer_UClass_UMyBuoyancyComponent(Z_Construct_UClass_UMyBuoyancyComponent, &UMyBuoyancyComponent::StaticClass, TEXT("/Script/DroneExp1"), TEXT("UMyBuoyancyComponent"), false, nullptr, nullptr, nullptr);
	DEFINE_VTABLE_PTR_HELPER_CTOR(UMyBuoyancyComponent);
PRAGMA_ENABLE_DEPRECATION_WARNINGS
#ifdef _MSC_VER
#pragma warning (pop)
#endif
