if(NOT TARGET Cinder-CppRESTSDK)
    # Define ${Cinder-CppRESTSDK_PROJECT_ROOT}. ${CMAKE_CURRENT_LIST_DIR} is just the current directory.
    get_filename_component(Cinder-CppRESTSDK_PROJECT_ROOT "${CMAKE_CURRENT_LIST_DIR}/../.." ABSOLUTE)

    # Define ${CINDER_PATH} as usual.
    get_filename_component(CINDER_PATH "${Cinder-CppRESTSDK_PROJECT_ROOT}/../.." ABSOLUTE)

    # Add include directories.
    target_include_directories(Cinder-CppRESTSDK PUBLIC "${Cinder-CppRESTSDK_PROJECT_ROOT}/include" )
    target_include_directories(Cinder-CppRESTSDK SYSTEM BEFORE PUBLIC "${CINDER_PATH}/include" )

    # Import pre-built libraries
    target_link_libraries(Cinder-CppRESTSDK "${Cinder-CppRESTSDK_PROJECT_ROOT}/lib/ms/x64/cpprest120d_2_8.lib")

    if(NOT TARGET cinder)
        include("${CINDER_PATH}/proj/cmake/configure.cmake")
        find_package(cinder REQUIRED PATHS
                "${CINDER_PATH}/${CINDER_LIB_DIRECTORY}"
                "$ENV{CINDER_PATH}/${CINDER_LIB_DIRECTORY}")
    endif()
    target_link_libraries(Cinder-CppRESTSDK PRIVATE cinder)

endif()