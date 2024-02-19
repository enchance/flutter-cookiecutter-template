#!/bin/bash/env python

import subprocess, shutil, os               # noqa
from pathlib import Path


def move_files_to_lib(project_name):
    curdir = Path(os.curdir).resolve()
    parentdir = curdir.parent
    libdir = os.path.join(curdir, project_name, 'lib')
    os.rename(os.path.join(libdir, 'main.dart'), os.path.join(libdir, '__main.dart'))
    shutil.move(os.path.join(curdir, '.github'), os.path.join(curdir, project_name))

    for item in os.listdir():
        if item != project_name:
            shutil.move(item, libdir)


    # Replace project folder with flutter folder
    os.rename(curdir, os.path.join(parentdir, f'__{project_name}'))
    shutil.move(project_name, parentdir)
    os.rmdir(os.path.join(parentdir, f'__{project_name}'))



def main():
    organization = "{{ cookiecutter.organization }}"
    project_name = "{{ cookiecutter.project_name }}"

    subprocess.run(["flutter", "create", "--org", organization, project_name])
    move_files_to_lib(project_name)


if __name__ == "__main__":
    main()
