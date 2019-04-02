import os
import os.path
import fnmatch
import logging
import ycm_core
import re

BASE_FLAGS = [
        '-Wall',
        '-Wextra',
        # '-Werror',
        '-Wno-long-long',
        '-Wno-variadic-macros',
        '-fexceptions',
        '-ferror-limit=10000',
        '-DNDEBUG',
        '-std=c++14',
        '-xc++',
        # '-I/usr/lib/',
        '-isystem/usr/include/',
        '-isystem/usr/local/include/',
        '-isystem/usr/include/pcl-1.7/',
        '-isystem/usr/include/eigen3/',
        '-isystem/usr/include/vtk-6.2/',
        '-isystem/usr/include/spinnaker',
        '-isystem/usr/include/lua5.3',
        '-isystem/opt/ros/kinetic/include/',
        '-isystem/opt/pylon5/include',

        #  '-I/usr/local/include/mrpt/base/include',
        #  '-I/usr/local/include/mrpt/gui/include',
        #  '-I/usr/local/include/mrpt/obs/include',
        #  '-I/usr/local/include/mrpt/maps/include',
        #  '-I/usr/local/include/mrpt/opengl/include',
        #  '-I/usr/local/include/mrpt/mrpt-config',

        #  '-I/home/linji/workspace/gaia/',
        #  '-I/home/linji/workspace/sensor_collector/include/',
        #  '-I/home/linji/workspace/sensor_collector/src/util/',

        '-I/home/linji/workspace/ros_sensor_collector/src/pylon_camera/include',
        '-I/home/linji/workspace/ros_sensor_collector/devel/include',
        '-I/home/linji/workspace/ros_sensor_collector/src/pointgrey_camera_driver/pointgrey_camera_driver/include/',

        #  '-I/home/linji/workspace/ros_sensor_collector/src/velodyne/velodyne_driver/include/',
        #  '-I/home/linji/workspace/ros_sensor_collector/src/velodyne/velodyne_pointcloud/include/',
        #  '-I/home/linji/workspace/ros_sensor_collector/src/time_sync/include',

        #  # '-I/home/linji/workspace/LeGO-LOAM/lego_loam_ws/src/LeGO-LOAM/include/',
        #  # '-I/home/linji/workspace/LeGO-LOAM/lego_loam_ws/src/LeGO-LOAM/devel/include/',

        #  # '-I/home/linji/workspace/LeGO-LOAM-chamo/lego_loam_ws/src/LeGO-LOAM/include/',
        #  # '-I/home/linji/workspace/LeGO-LOAM-chamo/lego_loam_ws/src/LeGO-LOAM/devel/include/',

        #  # '-I/home/linji/workspace/cartographer/src/cartographer',
        #  # '-I/home/linji/workspace/cartographer/src/cartographer_ros/cartographer_ros',
        #  # '-I/home/linji/workspace/cartographer/install_isolated/include',
        #  # '-I/home/linji/workspace/cartographer/build_isolated/cartographer/install',
        #  # '-I/home/linji/workspace/cartographer/build_isolated/cartographer_ros/abseil/src/abseil',

        #  '-I/home/linji/workspace/gaia/cartographer/src/cartographer',
        #  '-I/home/linji/workspace/gaia/cartographer/src/cartographer_ros/cartographer_ros',
        #  '-I/home/linji/workspace/gaia/cartographer/install_isolated/include',
        #  '-I/home/linji/workspace/gaia/cartographer/build_isolated/cartographer/install',
        #  '-I/home/linji/workspace/gaia/cartographer/build_isolated/cartographer_ros/abseil/src/abseil',

        #  # '-I/home/linji/workspace/gaia/lidar_localization/src/cartographer',
        #  # '-I/home/linji/workspace/gaia/lidar_localization/devel/include',
        #  # '-I/home/linji/workspace/gaia/lidar_localization/build/cartographer/abseil/src/abseil',

        #  '-I/home/linji/Documents/workspace/flycapture/',
        #  '-I/home/linji/Documents/workspace/pointgrey_camera_driver/',
        #  '-I/home/linji/Documents/workspace/pointgrey_camera_driver/pointgrey_camera_driver/include',


        #  '-I/home/linji/workspace/gaia/lidar_localization/devel/include',
        #  '-I/home/linji/workspace/gaia/lidar_localization/devel/include/startup',
        #  '-I/home/linji/workspace/gaia/lidar_localization/src/ndt_omp/include',
        #  '-I/home/linji/workspace/gaia/lidar_localization/src/startup/include',
        #  '-I/home/linji/workspace/gaia/lidar_localization/src/nio_msg_convertor/include',
        #  '-I/home/linji/workspace/gaia/lidar_localization/src/gps_tool/align_gps/include',
        #  '-I/home/linji/workspace/gaia/lidar_localization/devel/include/suitesparse',


        ]

SOURCE_EXTENSIONS = [
        '.cpp',
        '.cxx',
        '.cc',
        '.c',
        '.m',
        '.mm'
        ]

SOURCE_DIRECTORIES = [
        'source',
        'src',
        'lib'
        ]

HEADER_EXTENSIONS = [
        '.h',
        '.hxx',
        '.hpp',
        '.hh'
        ]

HEADER_DIRECTORIES = [
        'include'
        ]

def IsHeaderFile(filename):
    extension = os.path.splitext(filename)[1]
    return extension in HEADER_EXTENSIONS

def GetCompilationInfoForFile(database, filename):
    if IsHeaderFile(filename):
        basename = os.path.splitext(filename)[0]
        for extension in SOURCE_EXTENSIONS:
            # Get info from the source files by replacing the extension.
            replacement_file = basename + extension
            if os.path.exists(replacement_file):
                compilation_info = database.GetCompilationInfoForFile(replacement_file)
                if compilation_info.compiler_flags_:
                    return compilation_info
            # If that wasn't successful, try replacing possible header directory with possible source directories.
            for header_dir in HEADER_DIRECTORIES:
                for source_dir in SOURCE_DIRECTORIES:
                    src_file = replacement_file.replace(header_dir, source_dir)
                    if os.path.exists(src_file):
                        compilation_info = database.GetCompilationInfoForFile(src_file)
                        if compilation_info.compiler_flags_:
                            return compilation_info
        return None
    return database.GetCompilationInfoForFile(filename)

def FindNearest(path, target, build_folder):
    candidate = os.path.join(path, target)
    if(os.path.isfile(candidate) or os.path.isdir(candidate)):
        logging.info("Found nearest " + target + " at " + candidate)
        return candidate;

    parent = os.path.dirname(os.path.abspath(path));
    if(parent == path):
        raise RuntimeError("Could not find " + target);

    if(build_folder):
        candidate = os.path.join(parent, build_folder, target)
        if(os.path.isfile(candidate) or os.path.isdir(candidate)):
            logging.info("Found nearest " + target + " in build folder at " + candidate)
            return candidate;

    return FindNearest(parent, target, build_folder)

def MakeRelativePathsInFlagsAbsolute(flags, working_directory):
    if not working_directory:
        return list(flags)
    new_flags = []
    make_next_absolute = False
    path_flags = [ '-isystem', '-I', '-iquote', '--sysroot=' ]
    for flag in flags:
        new_flag = flag

        if make_next_absolute:
            make_next_absolute = False
            if not flag.startswith('/'):
                new_flag = os.path.join(working_directory, flag)

        for path_flag in path_flags:
            if flag == path_flag:
                make_next_absolute = True
                break

            if flag.startswith(path_flag):
                path = flag[ len(path_flag): ]
                new_flag = path_flag + os.path.join(working_directory, path)
                break

        if new_flag:
            new_flags.append(new_flag)
    return new_flags


def FlagsForClangComplete(root):
    try:
        clang_complete_path = FindNearest(root, '.clang_complete')
        clang_complete_flags = open(clang_complete_path, 'r').read().splitlines()
        return clang_complete_flags
    except:
        return None

def FlagsForInclude(root):
    try:
        include_path = FindNearest(root, 'include')
        flags = []
        for dirroot, dirnames, filenames in os.walk(include_path):
            for dir_path in dirnames:
                real_path = os.path.join(dirroot, dir_path)
                flags = flags + ["-I" + real_path]
        return flags
    except:
        return None

def FlagsForCompilationDatabase(root, filename):
    try:
        # Last argument of next function is the name of the build folder for
        # out of source projects
        compilation_db_path = FindNearest(root, 'compile_commands.json', 'build')
        compilation_db_dir = os.path.dirname(compilation_db_path)
        logging.info("Set compilation database directory to " + compilation_db_dir)
        compilation_db =  ycm_core.CompilationDatabase(compilation_db_dir)
        if not compilation_db:
            logging.info("Compilation database file found but unable to load")
            return None
        compilation_info = GetCompilationInfoForFile(compilation_db, filename)
        if not compilation_info:
            logging.info("No compilation info for " + filename + " in compilation database")
            return None
        return MakeRelativePathsInFlagsAbsolute(
                compilation_info.compiler_flags_,
                compilation_info.compiler_working_dir_)
    except:
        return None

def FlagsForFile(filename):
    root = os.path.realpath(filename);
    compilation_db_flags = FlagsForCompilationDatabase(root, filename)
    if compilation_db_flags:
        final_flags = compilation_db_flags
    else:
        final_flags = BASE_FLAGS
        clang_flags = FlagsForClangComplete(root)
        if clang_flags:
            final_flags = final_flags + clang_flags
        include_flags = FlagsForInclude(root)
        if include_flags:
            final_flags = final_flags + include_flags
    return {
            'flags': final_flags,
            'do_cache': True
            }
