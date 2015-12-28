BIN = bin
PKG = pkg
GOC = go build

% : src/%
	$(GOC) -o $(BIN)/$(@) $(@)

clean:
	rm -rf $(BIN)/*
	touch $(BIN) .gitkeep
