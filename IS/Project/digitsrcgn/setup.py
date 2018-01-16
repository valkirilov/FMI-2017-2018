from setuptools import setup

setup(
    name='digitsrcgn',
    packages=['digitsrcgn'],
    include_package_data=True,
    install_requires=[
        'flask',
        'numpy'
    ],
)