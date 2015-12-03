import qbs

Product {
    type: "application"
    Depends { name:"cpp" }
    cpp.defines: ["TOOLCHAIN_GCC_CW=1", "STM32F407xx"]
    cpp.positionIndependentCode: false
    cpp.debugInformation: true
    cpp.commonCompilerFlags: [
        "-mthumb","-mcpu=cortex-m4",
        "-mfloat-abi=hard","-mfpu=fpv4-sp-d16",
        "-fdata-sections","-ffunction-sections",
        "-fno-inline","-std=c99","-std=c++11","-flto"]
    cpp.linkerFlags:[
        "-flto","-mthumb","-mcpu=cortex-m4",
        "-mfloat-abi=hard","-mfpu=fpv4-sp-d16",
        "--specs=nano.specs","-Wl,--start-group",
        "-Wl,--gc-sections",
        //"-Obinary",
        "-T", path+"/stm32_flash.ld",
        "-lnosys","-lgcc","-lc"]
    cpp.includePaths: [
        "Drivers/CMSIS/Include",
        "Drivers/CMSIS/Device/ST/STM32F4xx/Include",
        "Drivers/STM32F4xx_HAL_Driver/Inc",
        "Middlewares/ST/STM32_USB_Device_Library/Core/Inc",
        "Middlewares/ST/STM32_USB_Device_Library/Class/CDC/Inc",
        "Inc"
    ]
    files: [
        "Drivers/STM32F4xx_HAL_Driver/Src/*",
        "Middlewares/ST/STM32_USB_Device_Library/Core/Src/*",
        "Middlewares/ST/STM32_USB_Device_Library/Class/CDC/Src/*",
        "Src/*"
    ]
    excludeFiles: [
        "Drivers/STM32F4xx_HAL_Driver/Src/*_template.c",
        "Middlewares/ST/STM32_USB_Device_Library/Core/Src/*_template.c",
        "Middlewares/ST/STM32_USB_Device_Library/Class/CDC/Src/*_template.c",
    ]
    Properties {
        condition: qbs.buildVariant === "debug"
        cpp.defines: outer.concat(["DEBUG=1"])
    }
    Group {
        qbs.install: true
        fileTagsFilter: "application"
    }
}
