INCLUDE(ExternalProject)

SET(MODULE_NAME libevent)
SET(LIBEVENT_SOURCES_DIR ${THIRD_PARTY_PATH}/${MODULE_NAME})
SET(LIBEVENT_INSTALL_DIR ${THIRD_PARTY_PATH}/install/${MODULE_NAME})
SET(LIBEVENT_INCLUDE_DIR "${LIBEVENT_INSTALL_DIR}/include" CACHE PATH "libevent include directory." FORCE)
SET(LIBEVENT_LIBRARIES "${LIBEVENT_INSTALL_DIR}/lib/libevent.a" CACHE FILEPATH "libevent library." FORCE)

INCLUDE_DIRECTORIES(${LIBEVENT_INCLUDE_DIR})

set(prefix_path "${LIBEVENT_INSTALL_DIR}")

ExternalProject_Add(
        extern_libevent
        ${EXTERNAL_PROJECT_LOG_ARGS}
        GIT_REPOSITORY "https://github.com/libevent/libevent"
        GIT_TAG "release-2.1.12-stable"
        PREFIX ${LIBEVENT_SOURCES_DIR}
        UPDATE_COMMAND ""
        CMAKE_ARGS -DCMAKE_CXX_COMPILER=${CMAKE_CXX_COMPILER}
        -DCMAKE_C_COMPILER=${CMAKE_C_COMPILER}
        -DCMAKE_CXX_FLAGS=${CMAKE_CXX_FLAGS}
        -DCMAKE_CXX_FLAGS_RELEASE=${CMAKE_CXX_FLAGS_RELEASE}
        -DCMAKE_CXX_FLAGS_DEBUG=${CMAKE_CXX_FLAGS_DEBUG}
        -DCMAKE_C_FLAGS=${CMAKE_C_FLAGS}
        -DCMAKE_C_FLAGS_DEBUG=${CMAKE_C_FLAGS_DEBUG}
        -DCMAKE_C_FLAGS_RELEASE=${CMAKE_C_FLAGS_RELEASE}
        -DCMAKE_INSTALL_PREFIX=${LIBEVENT_INSTALL_DIR}
        -DCMAKE_INSTALL_LIBDIR=${LIBEVENT_INSTALL_DIR}/lib
        -DCMAKE_POSITION_INDEPENDENT_CODE=ON
		-DEVENT__DISABLE_OPENSSL=ON
		-DEVENT__DISABLE_TESTS=ON
		-DEVENT__DISABLE_DEBUG_MODE=ON
		-DEVENT__DISABLE_BENCHMARK=ON
		-DEVENT__DISABLE_REGRESS=ON
		-DEVENT__DISABLE_SAMPLES=ON
		-DEVENT__FORCE_KQUEUE_CHECK=ON
		-DEVENT__LIBRARY_TYPE=STATIC
        -DCMAKE_BUILD_TYPE=${THIRD_PARTY_BUILD_TYPE}
        -DCMAKE_PREFIX_PATH=${prefix_path}
        ${EXTERNAL_OPTIONAL_ARGS}
)

ADD_LIBRARY(${MODULE_NAME} STATIC IMPORTED GLOBAL)
SET_PROPERTY(TARGET ${MODULE_NAME} PROPERTY IMPORTED_LOCATION ${LIBEVENT_LIBRARIES})
ADD_DEPENDENCIES(${MODULE_NAME} extern_libevent)
