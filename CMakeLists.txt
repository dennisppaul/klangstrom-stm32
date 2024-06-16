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
    Core/Inc
    FATFS/Target
    FATFS/App
    PDM2PCM/App
    USB_HOST/App
    USB_HOST/Target
    Drivers/STM32H7xx_HAL_Driver/Inc
    Drivers/STM32H7xx_HAL_Driver/Inc/Legacy
    Middlewares/Third_Party/FatFs/src
    Middlewares/ST/STM32_Audio/Addons/PDM/Inc
    Middlewares/ST/STM32_USB_Host_Library/Core/Inc
    Middlewares/ST/STM32_USB_Host_Library/Class/HID/Inc
    Drivers/CMSIS/Device/ST/STM32H7xx/Include
    Drivers/CMSIS/Include
)

target_compile_definitions(klangstrom-stm32 PUBLIC -DDEBUG -DUSE_HAL_DRIVER -DSTM32H723xx)