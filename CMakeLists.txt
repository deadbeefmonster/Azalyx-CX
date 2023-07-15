cmake_minimum_required(VERSION 3.14)

<<<<<<< HEAD
project(AzalyxCX LANGUAGES CXX)
=======
project(Clutching-Pearls-C2 LANGUAGES CXX)
>>>>>>> 08fa7af (Migrate to Qt6 and start new repository)

set(CMAKE_INCLUDE_CURRENT_DIR ON)

set(CMAKE_AUTOUIC ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

<<<<<<< HEAD
find_package(QT NAMES Qt6 REQUIRED COMPONENTS Core)
=======
find_package(QT NAMES Qt6 Qt5 REQUIRED COMPONENTS Core)
>>>>>>> 08fa7af (Migrate to Qt6 and start new repository)
find_package(Qt6 REQUIRED COMPONENTS Core)
find_package(Qt6 REQUIRED COMPONENTS Sql)
find_package(Qt6 REQUIRED COMPONENTS Network)

<<<<<<< HEAD
add_executable(${PROJECT_NAME}
=======
add_executable(Clutching-Pearls-C2
>>>>>>> 08fa7af (Migrate to Qt6 and start new repository)
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
<<<<<<< HEAD
target_include_directories(${PROJECT_NAME} PUBLIC src/include)
target_link_libraries(${PROJECT_NAME} Qt6::Core)
target_link_libraries(${PROJECT_NAME} Qt6::Sql)
target_link_libraries(${PROJECT_NAME} Qt6::Network)

=======
target_include_directories(Clutching-Pearls-C2 PUBLIC src/include)
target_link_libraries(Clutching-Pearls-C2 Qt6::Core)
target_link_libraries(Clutching-Pearls-C2 Qt6::Sql)
target_link_libraries(Clutching-Pearls-C2 Qt6::Network)
>>>>>>> 08fa7af (Migrate to Qt6 and start new repository)

