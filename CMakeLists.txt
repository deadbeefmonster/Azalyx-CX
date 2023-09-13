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

add_executable(${PROJECT_NAME}
    src/CommandHandler.cpp
    src/CommandShell.cpp
    src/DataEnvelope.cpp
    src/DataEnvelopeBody.cpp
    src/DataEnvelopeChunker.cpp
    src/DataEnvelopeFault.cpp
    src/DataEnvelopeHeader.cpp
    src/DataRequestProcessor.cpp
    src/DataResponseProcessor.cpp
    src/DataTransmogrifier.cpp
    src/Database.cpp
    src/InitializeSettings.cpp
    src/Logger.cpp
    src/ServiceTcp.cpp
    src/ServiceTcpProcessor.cpp
    src/ServiceTcpProcessorTask.cpp
    src/include/CommandHandler.h
    src/include/CommandInterface.h
    src/include/CommandShell.h
    src/include/DataEnvelope.h
    src/include/DataEnvelopeBody.h
    src/include/DataEnvelopeChunker.h
    src/include/DataEnvelopeFault.h
    src/include/DataEnvelopeHeader.h
    src/include/DataRequestProcessor.h
    src/include/DataResponseProcessor.h
    src/include/DataTransmogrifier.h
    src/include/Database.h
    src/include/InitializeSettings.h
    src/include/Logger.h
    src/include/ServiceTcp.h
    src/include/ServiceTcpProcessor.h
    src/include/ServiceTcpProcessorTask.h
    src/main.cpp
)


target_include_directories(${PROJECT_NAME} PUBLIC src/include)
target_link_libraries(${PROJECT_NAME} Qt6::Core)
target_link_libraries(${PROJECT_NAME} Qt6::Sql)
target_link_libraries(${PROJECT_NAME} Qt6::Network)
target_link_libraries(${PROJECT_NAME} Qt6::HttpServer)
target_link_libraries(${PROJECT_NAME} OpenSSL::SSL OpenSSL::Crypto)



