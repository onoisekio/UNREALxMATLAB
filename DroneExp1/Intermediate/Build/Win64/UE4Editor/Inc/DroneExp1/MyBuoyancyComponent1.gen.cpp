// Copyright Epic Games, Inc. All Rights Reserved.
/*===========================================================================
	Generated code exported from UnrealHeaderTool.
	DO NOT modify this manually! Edit the corresponding .h files instead!
===========================================================================*/

#include "UObject/GeneratedCppIncludes.h"
#include "DroneExp1/Public/MyBuoyancyComponent1.h"
#ifdef _MSC_VER
#pragma warning (push)
#pragma warning (disable : 4883)
#endif
PRAGMA_DISABLE_DEPRECATION_WARNINGS
void EmptyLinkFunctionForGeneratedCodeMyBuoyancyComponent1() {}
// Cross Module References
	DRONEEXP1_API UClass* Z_Construct_UClass_UMyBuoyancyComponent1_NoRegister();
	DRONEEXP1_API UClass* Z_Construct_UClass_UMyBuoyancyComponent1();
	WATER_API UClass* Z_Construct_UClass_UBuoyancyComponent();
	UPackage* Z_Construct_UPackage__Script_DroneExp1();
	COREUOBJECT_API UScriptStruct* Z_Construct_UScriptStruct_FVector();
// End Cross Module References
	DEFINE_FUNCTION(UMyBuoyancyComponent1::execAddPontoon)
	{
		P_GET_PROPERTY(FNameProperty,Z_Param_PontoonCenterSocket);
		P_GET_STRUCT(FVector,Z_Param_PontoonRelativeLocation);
		P_GET_PROPERTY(FFloatProperty,Z_Param_PontoonRadius);
		P_FINISH;
		P_NATIVE_BEGIN;
		P_THIS->AddPontoon(Z_Param_PontoonCenterSocket,Z_Param_PontoonRelativeLocation,Z_Param_PontoonRadius);
		P_NATIVE_END;
	}
	void UMyBuoyancyComponent1::StaticRegisterNativesUMyBuoyancyComponent1()
	{
		UClass* Class = UMyBuoyancyComponent1::StaticClass();
		static const FNameNativePtrPair Funcs[] = {
			{ "AddPontoon", &UMyBuoyancyComponent1::execAddPontoon },
		};
		FNativeFunctionRegistrar::RegisterFunctions(Class, Funcs, UE_ARRAY_COUNT(Funcs));
	}
	struct Z_Construct_UFunction_UMyBuoyancyComponent1_AddPontoon_Statics
	{
		struct MyBuoyancyComponent1_eventAddPontoon_Parms
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
	const UE4CodeGen_Private::FNamePropertyParams Z_Construct_UFunction_UMyBuoyancyComponent1_AddPontoon_Statics::NewProp_PontoonCenterSocket = { "PontoonCenterSocket", nullptr, (EPropertyFlags)0x0010000000000080, UE4CodeGen_Private::EPropertyGenFlags::Name, RF_Public|RF_Transient|RF_MarkAsNative, 1, STRUCT_OFFSET(MyBuoyancyComponent1_eventAddPontoon_Parms, PontoonCenterSocket), METADATA_PARAMS(nullptr, 0) };
	const UE4CodeGen_Private::FStructPropertyParams Z_Construct_UFunction_UMyBuoyancyComponent1_AddPontoon_Statics::NewProp_PontoonRelativeLocation = { "PontoonRelativeLocation", nullptr, (EPropertyFlags)0x0010000000000080, UE4CodeGen_Private::EPropertyGenFlags::Struct, RF_Public|RF_Transient|RF_MarkAsNative, 1, STRUCT_OFFSET(MyBuoyancyComponent1_eventAddPontoon_Parms, PontoonRelativeLocation), Z_Construct_UScriptStruct_FVector, METADATA_PARAMS(nullptr, 0) };
	const UE4CodeGen_Private::FFloatPropertyParams Z_Construct_UFunction_UMyBuoyancyComponent1_AddPontoon_Statics::NewProp_PontoonRadius = { "PontoonRadius", nullptr, (EPropertyFlags)0x0010000000000080, UE4CodeGen_Private::EPropertyGenFlags::Float, RF_Public|RF_Transient|RF_MarkAsNative, 1, STRUCT_OFFSET(MyBuoyancyComponent1_eventAddPontoon_Parms, PontoonRadius), METADATA_PARAMS(nullptr, 0) };
	const UE4CodeGen_Private::FPropertyParamsBase* const Z_Construct_UFunction_UMyBuoyancyComponent1_AddPontoon_Statics::PropPointers[] = {
		(const UE4CodeGen_Private::FPropertyParamsBase*)&Z_Construct_UFunction_UMyBuoyancyComponent1_AddPontoon_Statics::NewProp_PontoonCenterSocket,
		(const UE4CodeGen_Private::FPropertyParamsBase*)&Z_Construct_UFunction_UMyBuoyancyComponent1_AddPontoon_Statics::NewProp_PontoonRelativeLocation,
		(const UE4CodeGen_Private::FPropertyParamsBase*)&Z_Construct_UFunction_UMyBuoyancyComponent1_AddPontoon_Statics::NewProp_PontoonRadius,
	};
#if WITH_METADATA
	const UE4CodeGen_Private::FMetaDataPairParam Z_Construct_UFunction_UMyBuoyancyComponent1_AddPontoon_Statics::Function_MetaDataParams[] = {
		{ "Category", "Buoyancy" },
		{ "ModuleRelativePath", "Public/MyBuoyancyComponent1.h" },
	};
#endif
	const UE4CodeGen_Private::FFunctionParams Z_Construct_UFunction_UMyBuoyancyComponent1_AddPontoon_Statics::FuncParams = { (UObject*(*)())Z_Construct_UClass_UMyBuoyancyComponent1, nullptr, "AddPontoon", nullptr, nullptr, sizeof(MyBuoyancyComponent1_eventAddPontoon_Parms), Z_Construct_UFunction_UMyBuoyancyComponent1_AddPontoon_Statics::PropPointers, UE_ARRAY_COUNT(Z_Construct_UFunction_UMyBuoyancyComponent1_AddPontoon_Statics::PropPointers), RF_Public|RF_Transient|RF_MarkAsNative, (EFunctionFlags)0x04840401, 0, 0, METADATA_PARAMS(Z_Construct_UFunction_UMyBuoyancyComponent1_AddPontoon_Statics::Function_MetaDataParams, UE_ARRAY_COUNT(Z_Construct_UFunction_UMyBuoyancyComponent1_AddPontoon_Statics::Function_MetaDataParams)) };
	UFunction* Z_Construct_UFunction_UMyBuoyancyComponent1_AddPontoon()
	{
		static UFunction* ReturnFunction = nullptr;
		if (!ReturnFunction)
		{
			UE4CodeGen_Private::ConstructUFunction(ReturnFunction, Z_Construct_UFunction_UMyBuoyancyComponent1_AddPontoon_Statics::FuncParams);
		}
		return ReturnFunction;
	}
	UClass* Z_Construct_UClass_UMyBuoyancyComponent1_NoRegister()
	{
		return UMyBuoyancyComponent1::StaticClass();
	}
	struct Z_Construct_UClass_UMyBuoyancyComponent1_Statics
	{
		static UObject* (*const DependentSingletons[])();
		static const FClassFunctionLinkInfo FuncInfo[];
#if WITH_METADATA
		static const UE4CodeGen_Private::FMetaDataPairParam Class_MetaDataParams[];
#endif
		static const FCppClassTypeInfoStatic StaticCppClassTypeInfo;
		static const UE4CodeGen_Private::FClassParams ClassParams;
	};
	UObject* (*const Z_Construct_UClass_UMyBuoyancyComponent1_Statics::DependentSingletons[])() = {
		(UObject* (*)())Z_Construct_UClass_UBuoyancyComponent,
		(UObject* (*)())Z_Construct_UPackage__Script_DroneExp1,
	};
	const FClassFunctionLinkInfo Z_Construct_UClass_UMyBuoyancyComponent1_Statics::FuncInfo[] = {
		{ &Z_Construct_UFunction_UMyBuoyancyComponent1_AddPontoon, "AddPontoon" }, // 1863290332
	};
#if WITH_METADATA
	const UE4CodeGen_Private::FMetaDataPairParam Z_Construct_UClass_UMyBuoyancyComponent1_Statics::Class_MetaDataParams[] = {
		{ "Comment", "/**\n * \n */" },
		{ "IncludePath", "MyBuoyancyComponent1.h" },
		{ "ModuleRelativePath", "Public/MyBuoyancyComponent1.h" },
	};
#endif
	const FCppClassTypeInfoStatic Z_Construct_UClass_UMyBuoyancyComponent1_Statics::StaticCppClassTypeInfo = {
		TCppClassTypeTraits<UMyBuoyancyComponent1>::IsAbstract,
	};
	const UE4CodeGen_Private::FClassParams Z_Construct_UClass_UMyBuoyancyComponent1_Statics::ClassParams = {
		&UMyBuoyancyComponent1::StaticClass,
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
		METADATA_PARAMS(Z_Construct_UClass_UMyBuoyancyComponent1_Statics::Class_MetaDataParams, UE_ARRAY_COUNT(Z_Construct_UClass_UMyBuoyancyComponent1_Statics::Class_MetaDataParams))
	};
	UClass* Z_Construct_UClass_UMyBuoyancyComponent1()
	{
		static UClass* OuterClass = nullptr;
		if (!OuterClass)
		{
			UE4CodeGen_Private::ConstructUClass(OuterClass, Z_Construct_UClass_UMyBuoyancyComponent1_Statics::ClassParams);
		}
		return OuterClass;
	}
	IMPLEMENT_CLASS(UMyBuoyancyComponent1, 1993609514);
	template<> DRONEEXP1_API UClass* StaticClass<UMyBuoyancyComponent1>()
	{
		return UMyBuoyancyComponent1::StaticClass();
	}
	static FCompiledInDefer Z_CompiledInDefer_UClass_UMyBuoyancyComponent1(Z_Construct_UClass_UMyBuoyancyComponent1, &UMyBuoyancyComponent1::StaticClass, TEXT("/Script/DroneExp1"), TEXT("UMyBuoyancyComponent1"), false, nullptr, nullptr, nullptr);
	DEFINE_VTABLE_PTR_HELPER_CTOR(UMyBuoyancyComponent1);
PRAGMA_ENABLE_DEPRECATION_WARNINGS
#ifdef _MSC_VER
#pragma warning (pop)
#endif
