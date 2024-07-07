#THIS FILE IS AUTO GENERATED FROM THE TEMPLATE! DO NOT CHANGE!
if(DEFINED KLST_STM32_LIBRARY_PATH)
    message(STATUS "building klangstrom-stm32 as library")
    message(STATUS "KLST_STM32_LIBRARY_PATH is set to ${KLST_STM32_LIBRARY_PATH}")
    include(${KLST_STM32_LIBRARY_PATH}/cmake/library-config.cmake)
else()
    message(STATUS "building klangstrom-stm32 as executable. TODO not implemented yet")
    set(CMAKE_SYSTEM_NAME Generic)
    set(CMAKE_SYSTEM_VERSION 1)
    cmake_minimum_required(VERSION 3.29)

    # specify cross-compilers and tools
    set(CMAKE_C_COMPILER arm-none-eabi-gcc)
    set(CMAKE_CXX_COMPILER arm-none-eabi-g++)
    set(CMAKE_ASM_COMPILER  arm-none-eabi-gcc)
    set(CMAKE_AR arm-none-eabi-ar)
    set(CMAKE_OBJCOPY arm-none-eabi-objcopy)
    set(CMAKE_OBJDUMP arm-none-eabi-objdump)
    set(SIZE arm-none-eabi-size)
    set(CMAKE_TRY_COMPILE_TARGET_TYPE STATIC_LIBRARY)
    
    # project settings
    project(KLST_PANDA-STM32H723ZGT-BSP C CXX ASM)
    set(CMAKE_CXX_STANDARD 17)
    set(CMAKE_C_STANDARD 11)
    
    # @add(dpp)
    # for hardware floating point
    add_compile_definitions(ARM_MATH_CM4;ARM_MATH_MATRIX_CHECK;ARM_MATH_ROUNDING)
    add_compile_options(-mfloat-abi=hard -mfpu=fpv5-d16) 
    add_link_options(-mfloat-abi=hard -mfpu=fpv5-d16)
    # used to be `fpv4-sp-d16`
    
    #Uncomment for software floating point
    #add_compile_options(-mfloat-abi=soft)
    
    add_compile_options(-mcpu=cortex-m7 -mthumb -mthumb-interwork)
    add_compile_options(-ffunction-sections -fdata-sections -fno-common -fmessage-length=0)

    # @add(dpp)
    add_compile_options( -Wall -fstack-usage -fcyclomatic-complexity -MMD -MP --specs=nano.specs)
    
    # uncomment to mitigate c++17 absolute addresses warnings
    #set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wno-register")
    
    # Enable assembler files preprocessing
    add_compile_options($<$<COMPILE_LANGUAGE:ASM>:-x$<SEMICOLON>assembler-with-cpp>)
    
    if ("${CMAKE_BUILD_TYPE}" STREQUAL "Release")
        message(STATUS "Maximum optimization for speed")
        add_compile_options(-Ofast)
    elseif ("${CMAKE_BUILD_TYPE}" STREQUAL "RelWithDebInfo")
        message(STATUS "Maximum optimization for speed, debug info included")
        add_compile_options(-Ofast -g)
    elseif ("${CMAKE_BUILD_TYPE}" STREQUAL "MinSizeRel")
        message(STATUS "Maximum optimization for size")
        add_compile_options(-Os)
    else ()
        message(STATUS "Minimal optimization, debug info included")
        add_compile_options(-Og -g)
    endif ()
    
    include_directories(Core/Inc FATFS/Target FATFS/App PDM2PCM/App USB_HOST/App USB_HOST/Target Drivers/STM32H7xx_HAL_Driver/Inc Drivers/STM32H7xx_HAL_Driver/Inc/Legacy Middlewares/Third_Party/FatFs/src Middlewares/ST/STM32_Audio/Addons/PDM/Inc Middlewares/ST/STM32_USB_Host_Library/Core/Inc Middlewares/ST/STM32_USB_Host_Library/Class/HID/Inc Drivers/CMSIS/Device/ST/STM32H7xx/Include Drivers/CMSIS/Include)
    
    add_definitions(-DDEBUG -DUSE_HAL_DRIVER -DSTM32H723xx)
    
    file(GLOB_RECURSE SOURCES "PDM2PCM/*.*" "USB_HOST/*.*" "Core/*.*" "FATFS/*.*" "Middlewares/*.*" "Drivers/*.*")
    
    set(LINKER_SCRIPT ${CMAKE_SOURCE_DIR}/STM32H723ZGTX_FLASH.ld)
    
    add_link_options(-Wl,-gc-sections,--print-memory-usage,-Map=${PROJECT_BINARY_DIR}/${PROJECT_NAME}.map)
    add_link_options(-mcpu=cortex-m7 -mthumb -mthumb-interwork)
    add_link_options(-T ${LINKER_SCRIPT})
    
    add_executable(${PROJECT_NAME}.elf ${SOURCES} ${LINKER_SCRIPT})
    
    set(HEX_FILE ${PROJECT_BINARY_DIR}/${PROJECT_NAME}.hex)
    set(BIN_FILE ${PROJECT_BINARY_DIR}/${PROJECT_NAME}.bin)
    
    add_custom_command(TARGET ${PROJECT_NAME}.elf POST_BUILD
            COMMAND ${CMAKE_OBJCOPY} -Oihex $<TARGET_FILE:${PROJECT_NAME}.elf> ${HEX_FILE}
            COMMAND ${CMAKE_OBJCOPY} -Obinary $<TARGET_FILE:${PROJECT_NAME}.elf> ${BIN_FILE}
            COMMENT "Building ${HEX_FILE}
    Building ${BIN_FILE}")
endif()