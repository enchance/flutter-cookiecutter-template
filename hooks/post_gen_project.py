#!/bin/bash/env python

import subprocess, shutil, os  # noqa
from pathlib import Path

dependencies = {
    'auth': '''
flutter pub add firebase_core firebase_auth firebase_app_check \
    cloud_firestore cloud_functions firebase_storage firebase_analytics \
    firebase_remote_config firebase_crashlytics \
    google_sign_in purchases_flutter
''',
    'primary': '''
flutter pub add flutter_dotenv go_router dio slugify uuid intl logger \
    freezed freezed_annotation json_serializable json_annotation \
    flutter_riverpod riverpod_annotation dev:riverpod_lint \
    dev:riverpod_generator dev:build_runner \
    shared_preferences flutter_secure_storage settings_ui \
    cached_network_image flutter_form_builder form_builder_validators \
    responsive_framework infinite_scroll_pagination image_picker
''',
    'secondary': '''
flutter pub add icons_plus google_fonts flutter_spinkit shimmer dev:test \
    flutter_markdown permission_handler dev:flutter_launcher_icons \
    dev:custom_lint package_info_plus flutter_native_splash url_launcher \
    introduction_screen loading_animation_widget
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

    {% if cookiecutter.enable_google_signin %}
    subprocess.run('flutterfire configure'.split())
    {% endif %}

    subprocess.run(dependencies.get('auth').split())
    subprocess.run(dependencies.get('primary').split())
    subprocess.run(dependencies.get('secondary').split())
    os.chdir('..')

    testdir = os.path.join(project_name, 'test')
    os.rename(os.path.join(testdir, 'widget_test.dart'), os.path.join(testdir, 'widget.dart'))

    move_files_to_lib(project_name)

    print('-----------------------------------------')
    print('[SUCCESS] Next steps:')
    print('1. Set minSdkVersion to 29 in /android/app/build.gradle')
    print('2. Define flavors in /android/app/build.gradle: https://docs.flutter.dev/deployment/flavors')
    print('3. Firebase setup: https://firebase.google.com/docs/flutter/setup?platform=android')
    print('4. AppCheck setup: https://docs.flutter.dev/deployment/android#sign-the-app')
    print('5. Enable android:usesCleartextTraffic="true" in android/app/src/debug/AndroidManifest.xml')
    # print(type('{{ cookiecutter.enable_google_signin }}' == 'True'),
    #       '{{ cookiecutter.enable_google_signin }}' == 'True')


if __name__ == "__main__":
    main()
