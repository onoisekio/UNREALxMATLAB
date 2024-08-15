// Copyright Epic Games, Inc. All Rights Reserved.
/*===========================================================================
	Generated code exported from UnrealHeaderTool.
	DO NOT modify this manually! Edit the corresponding .h files instead!
===========================================================================*/

#include "UObject/GeneratedCppIncludes.h"
#include "DroneExp1/Public/MyShipAnimInstance.h"
#include "Engine/Classes/Components/SkeletalMeshComponent.h"
#ifdef _MSC_VER
#pragma warning (push)
#pragma warning (disable : 4883)
#endif
PRAGMA_DISABLE_DEPRECATION_WARNINGS
void EmptyLinkFunctionForGeneratedCodeMyShipAnimInstance() {}
// Cross Module References
	DRONEEXP1_API UClass* Z_Construct_UClass_UMyShipAnimInstance_NoRegister();
	DRONEEXP1_API UClass* Z_Construct_UClass_UMyShipAnimInstance();
	ENGINE_API UClass* Z_Construct_UClass_UAnimInstance();
	UPackage* Z_Construct_UPackage__Script_DroneExp1();
// End Cross Module References
	void UMyShipAnimInstance::StaticRegisterNativesUMyShipAnimInstance()
	{
	}
	UClass* Z_Construct_UClass_UMyShipAnimInstance_NoRegister()
	{
		return UMyShipAnimInstance::StaticClass();
	}
	struct Z_Construct_UClass_UMyShipAnimInstance_Statics
	{
		static UObject* (*const DependentSingletons[])();
#if WITH_METADATA
		static const UE4CodeGen_Private::FMetaDataPairParam Class_MetaDataParams[];
#endif
		static const FCppClassTypeInfoStatic StaticCppClassTypeInfo;
		static const UE4CodeGen_Private::FClassParams ClassParams;
	};
	UObject* (*const Z_Construct_UClass_UMyShipAnimInstance_Statics::DependentSingletons[])() = {
		(UObject* (*)())Z_Construct_UClass_UAnimInstance,
		(UObject* (*)())Z_Construct_UPackage__Script_DroneExp1,
	};
#if WITH_METADATA
	const UE4CodeGen_Private::FMetaDataPairParam Z_Construct_UClass_UMyShipAnimInstance_Statics::Class_MetaDataParams[] = {
		{ "Comment", "/**\n * \n */" },
		{ "HideCategories", "AnimInstance" },
		{ "IncludePath", "MyShipAnimInstance.h" },
		{ "ModuleRelativePath", "Public/MyShipAnimInstance.h" },
	};
#endif
	const FCppClassTypeInfoStatic Z_Construct_UClass_UMyShipAnimInstance_Statics::StaticCppClassTypeInfo = {
		TCppClassTypeTraits<UMyShipAnimInstance>::IsAbstract,
	};
	const UE4CodeGen_Private::FClassParams Z_Construct_UClass_UMyShipAnimInstance_Statics::ClassParams = {
		&UMyShipAnimInstance::StaticClass,
		nullptr,
		&StaticCppClassTypeInfo,
		DependentSingletons,
		nullptr,
		nullptr,
		nullptr,
		UE_ARRAY_COUNT(DependentSingletons),
		0,
		0,
		0,
		0x009000A8u,
		METADATA_PARAMS(Z_Construct_UClass_UMyShipAnimInstance_Statics::Class_MetaDataParams, UE_ARRAY_COUNT(Z_Construct_UClass_UMyShipAnimInstance_Statics::Class_MetaDataParams))
	};
	UClass* Z_Construct_UClass_UMyShipAnimInstance()
	{
		static UClass* OuterClass = nullptr;
		if (!OuterClass)
		{
			UE4CodeGen_Private::ConstructUClass(OuterClass, Z_Construct_UClass_UMyShipAnimInstance_Statics::ClassParams);
		}
		return OuterClass;
	}
	IMPLEMENT_CLASS(UMyShipAnimInstance, 1220005646);
	template<> DRONEEXP1_API UClass* StaticClass<UMyShipAnimInstance>()
	{
		return UMyShipAnimInstance::StaticClass();
	}
	static FCompiledInDefer Z_CompiledInDefer_UClass_UMyShipAnimInstance(Z_Construct_UClass_UMyShipAnimInstance, &UMyShipAnimInstance::StaticClass, TEXT("/Script/DroneExp1"), TEXT("UMyShipAnimInstance"), false, nullptr, nullptr, nullptr);
	DEFINE_VTABLE_PTR_HELPER_CTOR(UMyShipAnimInstance);
PRAGMA_ENABLE_DEPRECATION_WARNINGS
#ifdef _MSC_VER
#pragma warning (pop)
#endif
