# JupyterDesktop Bundle Image

Build ready to use Jupyter Notebook image with desktop proxy and common development tools.

## Included software
### From this repo
- Xfce Desktop Environment with proxy configured
- Compiler
	- C, C++
	- Fortran
	- Scala
- Text editor
	- Notepadqq
	- VScode
	- Atom
- Productivity
	- LibreOffice
	- Lyx
	- VLC
	- Firefox
### From base image
- Jupyter Notebook server
- [R](https://www.r-project.org/) interpreter and base environment 
	- [IRKernel](https://irkernel.github.io/)  to support R code in Jupyter notebooks
- Python with popular packages from the scientific Python ecosystem
- [Julia](https://julialang.org/) compiler and base environment
	- [IJulia](https://github.com/JuliaLang/IJulia.jl)  to support Julia code in Jupyter notebooks

## Built instructions
### From any [jupyter/docker-stacks](https://github.com/jupyter/docker-stacks) image
1. Clone the **main** branch
2. Change current directory to the repo
3. Edit `./Dockefile` to select the image
```
FROM jupyter/datascience-notebook:latest
```
4. run `docker build -t <TAG> .` to build image.
### For building GPU accelerated docker image
1. Clone the **GPU** branch
2. Easiest way is to build a GPU upon the image of [GPU-Jupyter](https://github.com/iot-salzburg/gpu-jupyter)
	a. Follow the instruction and comment out the last line in `./.build/Dockerfile` This will build an image without pre-configured password.
```
# Copy jupyter_notebook_config.json

# COPY jupyter_notebook_config.json /etc/jupyter/
```
3. Build and tag the image
4. Change current directory to the repo
5. Edit `./Dockefile` to select the image built in step 2.
```
FROM <tag-of-image>
```
6. run `docker build -t <TAG> .` to build image.

## Notes
- Electron Apps such as VScode and Atom can't start in a container environment without disabling sandbox with the `--no-sandbox` flag.
