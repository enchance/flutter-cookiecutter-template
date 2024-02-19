#!/bin/bash/env python

import subprocess, shutil, os               # noqa
from pathlib import Path


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

    # Replace project folder with flutter folder
    shutil.move(project_name, parentdir)
    shutil.rmtree(os.path.join(parentdir, project_folder))



def main():
    organization = "{{ cookiecutter.organization }}"
    project_name = "{{ cookiecutter.project_name }}"

    subprocess.run(["flutter", "create", "--org", organization, project_name])
    move_files_to_lib(project_name)


if __name__ == "__main__":
    main()
