""" For installing package. 
"""
import re
from setuptools import setup

# Descriptions
SHORT_DESCRIPTION = "Useful tools for machine learning mastery."
with open('README.md') as f:
    LONG_DESCRIPTION = f.read()

# version
with open('./src/__init__.py') as f:
    VERSION = next(
        re.finditer(
            r'\n__version__ *= *[\'\"]([0-9\.]+)[\'\"]',
            f.read(),
        )
    ).groups()[0]

setup(
    name='machine_learning_mastery_src',
    version=VERSION,
    author='Dylan Gregersen',
    author_email='an.email0101@gmail.com',
    url='https://github.com/earthastronaut/mlmastery',
    # license='MIT',
    description=SHORT_DESCRIPTION,
    long_description=LONG_DESCRIPTION,
    python_requires='>=3.6',
    # install_requires=[],
)
