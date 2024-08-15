// Copyright Epic Games, Inc. All Rights Reserved.
/*===========================================================================
	Generated code exported from UnrealHeaderTool.
	DO NOT modify this manually! Edit the corresponding .h files instead!
===========================================================================*/

#include "UObject/ObjectMacros.h"
#include "UObject/ScriptMacros.h"

PRAGMA_DISABLE_DEPRECATION_WARNINGS
class UStaticMeshComponent;
struct FVector;
#ifdef DRONEEXP1_MyBuoyancyComponent_generated_h
#error "MyBuoyancyComponent.generated.h already included, missing '#pragma once' in MyBuoyancyComponent.h"
#endif
#define DRONEEXP1_MyBuoyancyComponent_generated_h

#define DroneExp1_Source_DroneExp1_Public_MyBuoyancyComponent_h_13_SPARSE_DATA
#define DroneExp1_Source_DroneExp1_Public_MyBuoyancyComponent_h_13_RPC_WRAPPERS \
 \
	DECLARE_FUNCTION(execPresetPhysics); \
	DECLARE_FUNCTION(execPresetBuoyancy); \
	DECLARE_FUNCTION(execAddPontoon); \
	DECLARE_FUNCTION(execAddPontoons);


#define DroneExp1_Source_DroneExp1_Public_MyBuoyancyComponent_h_13_RPC_WRAPPERS_NO_PURE_DECLS \
 \
	DECLARE_FUNCTION(execPresetPhysics); \
	DECLARE_FUNCTION(execPresetBuoyancy); \
	DECLARE_FUNCTION(execAddPontoon); \
	DECLARE_FUNCTION(execAddPontoons);


#define DroneExp1_Source_DroneExp1_Public_MyBuoyancyComponent_h_13_INCLASS_NO_PURE_DECLS \
private: \
	static void StaticRegisterNativesUMyBuoyancyComponent(); \
	friend struct Z_Construct_UClass_UMyBuoyancyComponent_Statics; \
public: \
	DECLARE_CLASS(UMyBuoyancyComponent, UBuoyancyComponent, COMPILED_IN_FLAGS(0 | CLASS_Config), CASTCLASS_None, TEXT("/Script/DroneExp1"), NO_API) \
	DECLARE_SERIALIZER(UMyBuoyancyComponent)


#define DroneExp1_Source_DroneExp1_Public_MyBuoyancyComponent_h_13_INCLASS \
private: \
	static void StaticRegisterNativesUMyBuoyancyComponent(); \
	friend struct Z_Construct_UClass_UMyBuoyancyComponent_Statics; \
public: \
	DECLARE_CLASS(UMyBuoyancyComponent, UBuoyancyComponent, COMPILED_IN_FLAGS(0 | CLASS_Config), CASTCLASS_None, TEXT("/Script/DroneExp1"), NO_API) \
	DECLARE_SERIALIZER(UMyBuoyancyComponent)


#define DroneExp1_Source_DroneExp1_Public_MyBuoyancyComponent_h_13_STANDARD_CONSTRUCTORS \
	/** Standard constructor, called after all reflected properties have been initialized */ \
	NO_API UMyBuoyancyComponent(const FObjectInitializer& ObjectInitializer = FObjectInitializer::Get()); \
	DEFINE_DEFAULT_OBJECT_INITIALIZER_CONSTRUCTOR_CALL(UMyBuoyancyComponent) \
	DECLARE_VTABLE_PTR_HELPER_CTOR(NO_API, UMyBuoyancyComponent); \
DEFINE_VTABLE_PTR_HELPER_CTOR_CALLER(UMyBuoyancyComponent); \
private: \
	/** Private move- and copy-constructors, should never be used */ \
	NO_API UMyBuoyancyComponent(UMyBuoyancyComponent&&); \
	NO_API UMyBuoyancyComponent(const UMyBuoyancyComponent&); \
public:


#define DroneExp1_Source_DroneExp1_Public_MyBuoyancyComponent_h_13_ENHANCED_CONSTRUCTORS \
	/** Standard constructor, called after all reflected properties have been initialized */ \
	NO_API UMyBuoyancyComponent(const FObjectInitializer& ObjectInitializer = FObjectInitializer::Get()) : Super(ObjectInitializer) { }; \
private: \
	/** Private move- and copy-constructors, should never be used */ \
	NO_API UMyBuoyancyComponent(UMyBuoyancyComponent&&); \
	NO_API UMyBuoyancyComponent(const UMyBuoyancyComponent&); \
public: \
	DECLARE_VTABLE_PTR_HELPER_CTOR(NO_API, UMyBuoyancyComponent); \
DEFINE_VTABLE_PTR_HELPER_CTOR_CALLER(UMyBuoyancyComponent); \
	DEFINE_DEFAULT_OBJECT_INITIALIZER_CONSTRUCTOR_CALL(UMyBuoyancyComponent)


#define DroneExp1_Source_DroneExp1_Public_MyBuoyancyComponent_h_13_PRIVATE_PROPERTY_OFFSET
#define DroneExp1_Source_DroneExp1_Public_MyBuoyancyComponent_h_10_PROLOG
#define DroneExp1_Source_DroneExp1_Public_MyBuoyancyComponent_h_13_GENERATED_BODY_LEGACY \
PRAGMA_DISABLE_DEPRECATION_WARNINGS \
public: \
	DroneExp1_Source_DroneExp1_Public_MyBuoyancyComponent_h_13_PRIVATE_PROPERTY_OFFSET \
	DroneExp1_Source_DroneExp1_Public_MyBuoyancyComponent_h_13_SPARSE_DATA \
	DroneExp1_Source_DroneExp1_Public_MyBuoyancyComponent_h_13_RPC_WRAPPERS \
	DroneExp1_Source_DroneExp1_Public_MyBuoyancyComponent_h_13_INCLASS \
	DroneExp1_Source_DroneExp1_Public_MyBuoyancyComponent_h_13_STANDARD_CONSTRUCTORS \
public: \
PRAGMA_ENABLE_DEPRECATION_WARNINGS


#define DroneExp1_Source_DroneExp1_Public_MyBuoyancyComponent_h_13_GENERATED_BODY \
PRAGMA_DISABLE_DEPRECATION_WARNINGS \
public: \
	DroneExp1_Source_DroneExp1_Public_MyBuoyancyComponent_h_13_PRIVATE_PROPERTY_OFFSET \
	DroneExp1_Source_DroneExp1_Public_MyBuoyancyComponent_h_13_SPARSE_DATA \
	DroneExp1_Source_DroneExp1_Public_MyBuoyancyComponent_h_13_RPC_WRAPPERS_NO_PURE_DECLS \
	DroneExp1_Source_DroneExp1_Public_MyBuoyancyComponent_h_13_INCLASS_NO_PURE_DECLS \
	DroneExp1_Source_DroneExp1_Public_MyBuoyancyComponent_h_13_ENHANCED_CONSTRUCTORS \
private: \
PRAGMA_ENABLE_DEPRECATION_WARNINGS


template<> DRONEEXP1_API UClass* StaticClass<class UMyBuoyancyComponent>();

#undef CURRENT_FILE_ID
#define CURRENT_FILE_ID DroneExp1_Source_DroneExp1_Public_MyBuoyancyComponent_h


PRAGMA_ENABLE_DEPRECATION_WARNINGS
