# 各デモの swiftconstvalues を生成する。
# 出力先指定・protocols リストはドライバが知らない frontend オプションのため
# -Xfrontend で frontend に直接渡す。
DEMOS := basic appintents typesystem

.PHONY: all $(DEMOS)

all: $(DEMOS)

$(DEMOS):
	cd $@ && xcrun swiftc -typecheck Source.swift \
	  -Xfrontend -emit-const-values-path -Xfrontend Source.swiftconstvalues \
	  -Xfrontend -const-gather-protocols-file -Xfrontend protocols.json
