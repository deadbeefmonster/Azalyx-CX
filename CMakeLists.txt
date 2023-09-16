cmake_minimum_required(VERSION 3.14)


project(AzalyxCX LANGUAGES CXX)

set(CMAKE_INCLUDE_CURRENT_DIR ON)

set(CMAKE_AUTOUIC ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(QT NAMES Qt6 REQUIRED COMPONENTS Core)

find_package(Qt6 REQUIRED COMPONENTS Core)
find_package(Qt6 REQUIRED COMPONENTS Sql)
find_package(Qt6 REQUIRED COMPONENTS Network)
find_package(Qt6 REQUIRED COMPONENTS HttpServer)
find_package(OpenSSL REQUIRED)
include_directories(${OPENSSL_INCLUDE_DIR})


# find src -type f \( -name "*.cpp" -o -name "*.h" \) | sort
add_executable(${PROJECT_NAME}
    src/Command/CommandHandler.cpp
    src/Command/CommandHandler.h
    src/Command/CommandInterface.h
    src/Command/CommandShell.cpp
    src/Command/CommandShell.h
    src/Data/DataRequestProcessor.cpp
    src/Data/DataRequestProcessor.h
    src/Data/DataResponseProcessor.cpp
    src/Data/DataResponseProcessor.h
    src/Data/DataTransmogrifier.cpp
    src/Data/DataTransmogrifier.h
    src/Data/Envelope/DataEnvelope.cpp
    src/Data/Envelope/DataEnvelope.h
    src/Data/Envelope/DataEnvelopeBody.cpp
    src/Data/Envelope/DataEnvelopeBody.h
    src/Data/Envelope/DataEnvelopeChunker.cpp
    src/Data/Envelope/DataEnvelopeChunker.h
    src/Data/Envelope/DataEnvelopeFault.cpp
    src/Data/Envelope/DataEnvelopeFault.h
    src/Data/Envelope/DataEnvelopeHeader.cpp
    src/Data/Envelope/DataEnvelopeHeader.h
    src/Database/Database.cpp
    src/Database/Database.h
    src/Logger/Logger.cpp
    src/Logger/Logger.h
    src/Service/Tcp/ServiceTcp.cpp
    src/Service/Tcp/ServiceTcp.h
    src/Service/Tcp/ServiceTcpProcessor.cpp
    src/Service/Tcp/ServiceTcpProcessor.h
    src/Service/Tcp/ServiceTcpProcessorTask.cpp
    src/Service/Tcp/ServiceTcpProcessorTask.h
    src/Settings/SettingsInitialize.cpp
    src/Settings/SettingsInitialize.h
    src/main.cpp
)


# find src -type d | sort
target_include_directories(${PROJECT_NAME} PUBLIC
    src
    src/Command
    src/Data
    src/Data/Envelope
    src/Database
    src/Logger
    src/Service
    src/Service/Tcp
    src/Settings
)


target_link_libraries(${PROJECT_NAME} Qt6::Core)
target_link_libraries(${PROJECT_NAME} Qt6::Sql)
target_link_libraries(${PROJECT_NAME} Qt6::Network)
target_link_libraries(${PROJECT_NAME} Qt6::HttpServer)
target_link_libraries(${PROJECT_NAME} OpenSSL::SSL OpenSSL::Crypto)



