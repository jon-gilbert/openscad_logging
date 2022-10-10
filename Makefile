
current_dir = $(shell pwd)
testdir = tests
docsdir = docs
test_names = $(sort $(wildcard $(testdir)/test_*.scad))
m_test_names = $(sort $(wildcard $(testdir)/test_*.yscad))
srcs = logging.scad

all: test

doc:
	openscad-docsgen --force --gen-files --project-name "openscad_logging" --docs-dir $(docsdir) $(srcs)

test:
	for f in $(test_names); do OPENSCADPATH=$(current_dir) tests/run-test.sh $${f} || exit $?; done
	for f in $(m_test_names); do OPENSCADPATH=$(current_dir) tests/run-yscad-test.sh $${f} || exit $?; done

