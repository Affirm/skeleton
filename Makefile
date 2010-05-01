# Makefile for skeleton
PYTHON = python
GIT = git
VERSION = `$(PYTHON) -m skeleton.meta -v`

all: clean test dist

test:
	@echo "Running skeleton unit tests..."
	@echo ""
	$(PYTHON) -m skeleton.tests.run

build:
	@echo "Build squeleton package..."
	@echo ""
	$(PYTHON) setup.py build

dist: MANIFEST
	@echo "Build src distribution of skeleton..."
	@echo ""
	$(PYTHON) setup.py sdist

clean:
	@echo "Remove build and dist directories, and pyc files..."
	@echo ""
	rm -rf ./build/
	rm -rf ./dist/
	find . -name "*.pyc" | xargs rm

MANIFEST:
	@echo "Update MANIFEST.in..."
	git ls-files --exclude=".git*" > MANIFEST.in

release: clean test dist tag upload
	@echo "Version $(VERSION) released."
	
tag:
	$(git) pull origin master
	$(git) tag v$(VERSION)
	$(git) push origin v$(VERSION)

upload:
	$(PYTHON) setup.py
