// Copyright Epic Games, Inc. All Rights Reserved.
/*===========================================================================
	Generated code exported from UnrealHeaderTool.
	DO NOT modify this manually! Edit the corresponding .h files instead!
===========================================================================*/

#include "UObject/ObjectMacros.h"
#include "UObject/ScriptMacros.h"

PRAGMA_DISABLE_DEPRECATION_WARNINGS
struct FVector;
#ifdef DRONEEXP1_IceSpawnerClass_generated_h
#error "IceSpawnerClass.generated.h already included, missing '#pragma once' in IceSpawnerClass.h"
#endif
#define DRONEEXP1_IceSpawnerClass_generated_h

#define DroneExp1_Source_DroneExp1_Public_IceSpawnerClass_h_13_SPARSE_DATA
#define DroneExp1_Source_DroneExp1_Public_IceSpawnerClass_h_13_RPC_WRAPPERS \
 \
	DECLARE_FUNCTION(execClearActiveIcePieces); \
	DECLARE_FUNCTION(execSpawnIcePiece); \
	DECLARE_FUNCTION(execSpawnAllRegions); \
	DECLARE_FUNCTION(execSpawnNextRegion); \
	DECLARE_FUNCTION(execInit);


#define DroneExp1_Source_DroneExp1_Public_IceSpawnerClass_h_13_RPC_WRAPPERS_NO_PURE_DECLS \
 \
	DECLARE_FUNCTION(execClearActiveIcePieces); \
	DECLARE_FUNCTION(execSpawnIcePiece); \
	DECLARE_FUNCTION(execSpawnAllRegions); \
	DECLARE_FUNCTION(execSpawnNextRegion); \
	DECLARE_FUNCTION(execInit);


#define DroneExp1_Source_DroneExp1_Public_IceSpawnerClass_h_13_INCLASS_NO_PURE_DECLS \
private: \
	static void StaticRegisterNativesAIceSpawnerClass(); \
	friend struct Z_Construct_UClass_AIceSpawnerClass_Statics; \
public: \
	DECLARE_CLASS(AIceSpawnerClass, AActor, COMPILED_IN_FLAGS(0 | CLASS_Config), CASTCLASS_None, TEXT("/Script/DroneExp1"), NO_API) \
	DECLARE_SERIALIZER(AIceSpawnerClass) \
	static const TCHAR* StaticConfigName() {return TEXT("Game");} \



#define DroneExp1_Source_DroneExp1_Public_IceSpawnerClass_h_13_INCLASS \
private: \
	static void StaticRegisterNativesAIceSpawnerClass(); \
	friend struct Z_Construct_UClass_AIceSpawnerClass_Statics; \
public: \
	DECLARE_CLASS(AIceSpawnerClass, AActor, COMPILED_IN_FLAGS(0 | CLASS_Config), CASTCLASS_None, TEXT("/Script/DroneExp1"), NO_API) \
	DECLARE_SERIALIZER(AIceSpawnerClass) \
	static const TCHAR* StaticConfigName() {return TEXT("Game");} \



#define DroneExp1_Source_DroneExp1_Public_IceSpawnerClass_h_13_STANDARD_CONSTRUCTORS \
	/** Standard constructor, called after all reflected properties have been initialized */ \
	NO_API AIceSpawnerClass(const FObjectInitializer& ObjectInitializer); \
	DEFINE_DEFAULT_OBJECT_INITIALIZER_CONSTRUCTOR_CALL(AIceSpawnerClass) \
	DECLARE_VTABLE_PTR_HELPER_CTOR(NO_API, AIceSpawnerClass); \
DEFINE_VTABLE_PTR_HELPER_CTOR_CALLER(AIceSpawnerClass); \
private: \
	/** Private move- and copy-constructors, should never be used */ \
	NO_API AIceSpawnerClass(AIceSpawnerClass&&); \
	NO_API AIceSpawnerClass(const AIceSpawnerClass&); \
public:


#define DroneExp1_Source_DroneExp1_Public_IceSpawnerClass_h_13_ENHANCED_CONSTRUCTORS \
private: \
	/** Private move- and copy-constructors, should never be used */ \
	NO_API AIceSpawnerClass(AIceSpawnerClass&&); \
	NO_API AIceSpawnerClass(const AIceSpawnerClass&); \
public: \
	DECLARE_VTABLE_PTR_HELPER_CTOR(NO_API, AIceSpawnerClass); \
DEFINE_VTABLE_PTR_HELPER_CTOR_CALLER(AIceSpawnerClass); \
	DEFINE_DEFAULT_CONSTRUCTOR_CALL(AIceSpawnerClass)


#define DroneExp1_Source_DroneExp1_Public_IceSpawnerClass_h_13_PRIVATE_PROPERTY_OFFSET
#define DroneExp1_Source_DroneExp1_Public_IceSpawnerClass_h_10_PROLOG
#define DroneExp1_Source_DroneExp1_Public_IceSpawnerClass_h_13_GENERATED_BODY_LEGACY \
PRAGMA_DISABLE_DEPRECATION_WARNINGS \
public: \
	DroneExp1_Source_DroneExp1_Public_IceSpawnerClass_h_13_PRIVATE_PROPERTY_OFFSET \
	DroneExp1_Source_DroneExp1_Public_IceSpawnerClass_h_13_SPARSE_DATA \
	DroneExp1_Source_DroneExp1_Public_IceSpawnerClass_h_13_RPC_WRAPPERS \
	DroneExp1_Source_DroneExp1_Public_IceSpawnerClass_h_13_INCLASS \
	DroneExp1_Source_DroneExp1_Public_IceSpawnerClass_h_13_STANDARD_CONSTRUCTORS \
public: \
PRAGMA_ENABLE_DEPRECATION_WARNINGS


#define DroneExp1_Source_DroneExp1_Public_IceSpawnerClass_h_13_GENERATED_BODY \
PRAGMA_DISABLE_DEPRECATION_WARNINGS \
public: \
	DroneExp1_Source_DroneExp1_Public_IceSpawnerClass_h_13_PRIVATE_PROPERTY_OFFSET \
	DroneExp1_Source_DroneExp1_Public_IceSpawnerClass_h_13_SPARSE_DATA \
	DroneExp1_Source_DroneExp1_Public_IceSpawnerClass_h_13_RPC_WRAPPERS_NO_PURE_DECLS \
	DroneExp1_Source_DroneExp1_Public_IceSpawnerClass_h_13_INCLASS_NO_PURE_DECLS \
	DroneExp1_Source_DroneExp1_Public_IceSpawnerClass_h_13_ENHANCED_CONSTRUCTORS \
private: \
PRAGMA_ENABLE_DEPRECATION_WARNINGS


template<> DRONEEXP1_API UClass* StaticClass<class AIceSpawnerClass>();

#undef CURRENT_FILE_ID
#define CURRENT_FILE_ID DroneExp1_Source_DroneExp1_Public_IceSpawnerClass_h


PRAGMA_ENABLE_DEPRECATION_WARNINGS
