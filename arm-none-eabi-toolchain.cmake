set(CMAKE_SYSTEM_NAME               Generic)
set(CMAKE_SYSTEM_PROCESSOR          arm)

set(CMAKE_C_COMPILER_FORCED TRUE)
set(CMAKE_CXX_COMPILER_FORCED TRUE)
set(CMAKE_C_COMPILER_ID GNU)
set(CMAKE_CXX_COMPILER_ID GNU)

# Some default GCC settings
# arm-none-eabi- must be part of PATH environment
set(TOOLCHAIN_PREFIX                arm-none-eabi-)

set(CMAKE_C_COMPILER                ${TOOLCHAIN_PREFIX}gcc)
set(CMAKE_ASM_COMPILER              ${CMAKE_C_COMPILER})
set(CMAKE_CXX_COMPILER              ${TOOLCHAIN_PREFIX}g++)
set(CMAKE_LINKER                    ${TOOLCHAIN_PREFIX}g++)
set(CMAKE_OBJCOPY                   ${TOOLCHAIN_PREFIX}objcopy)
set(CMAKE_SIZE                      ${TOOLCHAIN_PREFIX}size)

set(CMAKE_EXECUTABLE_SUFFIX_ASM     ".elf")
set(CMAKE_EXECUTABLE_SUFFIX_C       ".elf")
set(CMAKE_EXECUTABLE_SUFFIX_CXX     ".elf")

set(CMAKE_TRY_COMPILE_TARGET_TYPE STATIC_LIBRARY)

# MCU specific flags
set(TARGET_FLAGS "-mcpu=cortex-m7 -mfpu=fpv4-sp-d16 -mfloat-abi=hard -mthumb -mthumb-interwork")

add_compile_definitions(ARM_MATH_CM4 ARM_MATH_MATRIX_CHECK ARM_MATH_ROUNDING)

# Common C flags
set(COMMON_C_FLAGS "-fdata-sections -ffunction-sections -fno-common -fmessage-length=0")

# Common linker flags
set(COMMON_LINK_FLAGS "-Wl,-Map=${CMAKE_PROJECT_NAME}.map -Wl,--gc-sections -Wl,--start-group -lc -lm -Wl,--end-group -Wl,--print-memory-usage")

# Adjust flags based on build type
if(CMAKE_BUILD_TYPE MATCHES Debug)
    set(CMAKE_C_FLAGS_DEBUG "-O0 -g3")
endif()
if(CMAKE_BUILD_TYPE MATCHES Release)
    set(CMAKE_C_FLAGS_RELEASE "-Os -g0")
endif()

# Set the flags for the project
set(CMAKE_C_FLAGS "${TARGET_FLAGS} ${COMMON_C_FLAGS} ${CMAKE_C_FLAGS_DEBUG}")
set(CMAKE_ASM_FLAGS "${TARGET_FLAGS} ${COMMON_C_FLAGS} -x assembler-with-cpp -MMD -MP")
set(CMAKE_CXX_FLAGS "${TARGET_FLAGS} ${COMMON_C_FLAGS} -fno-rtti -fno-exceptions -fno-threadsafe-statics ${CMAKE_C_FLAGS_DEBUG}")
set(CMAKE_EXE_LINKER_FLAGS "${TARGET_FLAGS} -T${LIBRARY_PATH}/STM32H723ZGTX_FLASH.ld --specs=nano.specs ${COMMON_LINK_FLAGS}")

# Set C++ linker flags separately to add standard C++ libraries
set(CMAKE_CXX_LINK_FLAGS "${TARGET_FLAGS} ${COMMON_LINK_FLAGS} -Wl,--start-group -lstdc++ -lsupc++ -Wl,--end-group")
