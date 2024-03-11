#!/bin/bash/env python

import subprocess, shutil, os  # noqa
from pathlib import Path

dependencies = {
    'auth': '''
flutter pub add purchases_flutter firebase_core firebase_app_check firebase_auth \
    cloud_firestore firebase_storage cloud_functions google_sign_in
''',
    'main': '''
flutter pub add flutter_dotenv go_router dio logger flutter_native_splash dev:flutter_launcher_icons slugify \
    shared_preferences flutter_secure_storage settings_ui infinite_scroll_pagination flutter_markdown \
    flutter_riverpod riverpod_annotation dev:riverpod_generator dev:build_runner dev:custom_lint dev:riverpod_lint \
    freezed_annotation dev:freezed json_annotation dev:json_serializable \
    flutter_form_builder form_builder_validators responsive_framework cached_network_image \
    icons_plus google_fonts lottie flutter_spinkit \
    internet_connection_checker visibility_detector
''',
}


def move_files_to_lib(project_name):
    project_folder = f'__{project_name}'
    os.rename(Path(os.curdir).resolve(), os.path.join(Path(os.curdir).resolve().parent, project_folder))

    projectdir = Path(os.curdir).resolve()
    parentdir = projectdir.parent

    templatelib = os.path.join(projectdir, 'lib')
    libdir = os.path.join(project_name, 'lib')
    os.rename(os.path.join(libdir, 'main.dart'), os.path.join(libdir, '__main.dart'))

    # print(templatelib)
    # print(libdir)
    # print(projectdir)
    # print(parentdir)

    # Move root files
    for item in os.listdir():
        if item not in ['lib', project_name]:
            src = os.path.join(projectdir, item)
            dest = os.path.join(projectdir, project_name)
            if os.path.exists(os.path.join(dest, item)):
                os.remove(os.path.join(dest, item))
            shutil.move(src, dest)

    # Move lib files
    for item in os.listdir(templatelib):
        src = os.path.join(templatelib, item)
        shutil.move(src, libdir)

    # Move entire flutter folder
    shutil.move(project_name, parentdir)
    shutil.rmtree(os.path.join(parentdir, project_folder))


def main():
    organization = "{{ cookiecutter.organization }}"
    project_name = "{{ cookiecutter.project_name }}"

    subprocess.run(f'flutter create --org {organization} {project_name}'.split())

    os.chdir(project_name)
    subprocess.run('flutterfire configure'.split())
    subprocess.run(dependencies.get('auth').split())
    subprocess.run(dependencies.get('main').split())
    os.chdir('..')

    move_files_to_lib(project_name)

    print('-----------------------------------------')
    print('[SUCCESS] Next steps:')
    print('- Set minSdkVersion to 29 in android/app/build.gradle')
    print('- Enable android:usesCleartextTraffic="true" in android/app/src/debug/AndroidManifest.xml')
    # print(type('{{ cookiecutter.enable_google_signin }}' == 'True'),
    #       '{{ cookiecutter.enable_google_signin }}' == 'True')


if __name__ == "__main__":
    main()
