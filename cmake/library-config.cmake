file(GLOB_RECURSE SOURCES
        "PDM2PCM/*.*"
        "USB_HOST/*.*"
        "Core/*.*"
        "FATFS/*.*"
        "Middlewares/*.*"
        "Drivers/*.*"
)

add_library(klangstrom-stm32 STATIC ${SOURCES})

target_include_directories(klangstrom-stm32 PUBLIC
        ${KLST_STM32_LIBRARY_PATH}/Core/Inc
        ${KLST_STM32_LIBRARY_PATH}/FATFS/Target
        ${KLST_STM32_LIBRARY_PATH}/FATFS/App
        ${KLST_STM32_LIBRARY_PATH}/PDM2PCM/App
        ${KLST_STM32_LIBRARY_PATH}/USB_HOST/App
        ${KLST_STM32_LIBRARY_PATH}/USB_HOST/Target
        ${KLST_STM32_LIBRARY_PATH}/Drivers/STM32H7xx_HAL_Driver/Inc
        ${KLST_STM32_LIBRARY_PATH}/Drivers/STM32H7xx_HAL_Driver/Inc/Legacy
        ${KLST_STM32_LIBRARY_PATH}/Middlewares/Third_Party/FatFs/src
        ${KLST_STM32_LIBRARY_PATH}/Middlewares/ST/STM32_Audio/Addons/PDM/Inc
        ${KLST_STM32_LIBRARY_PATH}/Middlewares/ST/STM32_USB_Host_Library/Core/Inc
        ${KLST_STM32_LIBRARY_PATH}/Middlewares/ST/STM32_USB_Host_Library/Class/HID/Inc
        ${KLST_STM32_LIBRARY_PATH}/Drivers/CMSIS/Device/ST/STM32H7xx/Include
        ${KLST_STM32_LIBRARY_PATH}/Drivers/CMSIS/Include
)

target_compile_definitions(klangstrom-stm32 PUBLIC -DDEBUG -DUSE_HAL_DRIVER -DSTM32H723xx)

# PDM Library

set(PDM_LIBRARY_PATH "${KLST_STM32_LIBRARY_PATH}/Middlewares/ST/STM32_Audio/Addons/PDM")
set(PDM_STATIC_LIBRARY_PATH "${PDM_LIBRARY_PATH}/Lib")
set(PDM_LIBRARY_INCLUDE "${PDM_LIBRARY_PATH}/Inc")
target_include_directories(klangstrom-stm32 PUBLIC ${PDM_LIBRARY_INCLUDE})
target_link_libraries(klangstrom-stm32 PUBLIC ${PDM_STATIC_LIBRARY_PATH}/libPDMFilter_CM7_GCC_wc32.a)
