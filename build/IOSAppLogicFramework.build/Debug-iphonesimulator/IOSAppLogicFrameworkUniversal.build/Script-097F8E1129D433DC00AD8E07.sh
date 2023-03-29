#!/bin/sh
# Type a script or drag a script file from your workspace to insert its path.
echo "project"
# 1) Открываем "${PROJECT_DIR}"
if [ "true" == ${ALREADYINVOKED:-false} ]
then
echo "RECURSION: Detected, stopping"
else
export ALREADYINVOKED="true"

UNIVERSAL_OUTPUTFOLDER=${BUILD_DIR}/${CONFIGURATION}-iosuniversal

# 2) Переходим (либо создаем) папку с выходными файлами
mkdir -p "${UNIVERSAL_OUTPUTFOLDER}"

# 3) Билдим для устройства и симулятора
echo "iphone"
xcodebuild -target "${TARGET_NAME}" ONLY_ACTIVE_ARCH=NO -configuration ${CONFIGURATION} -sdk iphoneos  BUILD_DIR="${BUILD_DIR}" BUILD_ROOT="${BUILD_ROOT}" build

echo "iphonesim"
xcodebuild -target "${TARGET_NAME}" -configuration ${CONFIGURATION} -sdk iphonesimulator ONLY_ACTIVE_ARCH=NO BUILD_DIR="${BUILD_DIR}" BUILD_ROOT="${BUILD_ROOT}" build

# 4) Копируем из папки Debug-iphoneos в папку universal
echo "universal"
cp -R "${BUILD_DIR}/${CONFIGURATION}-iphoneos/${PROJECT_NAME}.framework" "${UNIVERSAL_OUTPUTFOLDER}/"

# 5) Копируем swift modules
echo "iphone simulator path"
SIMULATOR_SWIFT_MODULES_DIR="${BUILD_DIR}/${CONFIGURATION}-iphonesimulator/${PROJECT_NAME}.framework/Modules/${PROJECT_NAME}.swiftmodule/."
if [ -d "${SIMULATOR_SWIFT_MODULES_DIR}" ]; then
cp -R "${SIMULATOR_SWIFT_MODULES_DIR}" "${UNIVERSAL_OUTPUTFOLDER}/${PROJECT_NAME}.framework/Modules/${PROJECT_NAME}.swiftmodule"
fi

# 6) С помощью lipo создаем universal framework
echo "lipo create"
lipo -create -output "${UNIVERSAL_OUTPUTFOLDER}/${PROJECT_NAME}.framework/${PROJECT_NAME}" "${BUILD_DIR}/${CONFIGURATION}-iphonesimulator/${PROJECT_NAME}.framework/${PROJECT_NAME}" "${BUILD_DIR}/${CONFIGURATION}-iphoneos/${PROJECT_NAME}.framework/${PROJECT_NAME}"

echo "end"
fi

