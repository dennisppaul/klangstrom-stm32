if(DEFINED LIBRARY_PATH)
    message(STATUS "building klangstrom-stm32 as library")
    message(STATUS "LIBRARY_PATH is set to ${LIBRARY_PATH}")
    include(${LIBRARY_PATH}/cmake/library-config.cmake)
else()
    message(FATAL_ERROR "building klangstrom-stm32 as executable. TODO not implemented yet")
endif()

