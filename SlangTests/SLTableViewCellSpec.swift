import Quick
import Nimble

class SLBlankTableViewCellTest: QuickSpec {
    override func spec() {
        it("has a SLBlank type") {
            let cell = SLBlankTableViewCell(style: .Default, reuseIdentifier: nil)
            expect(cell.type) == BlockType.SLBlank
        }
    }
}

class SLVariableTableViewCellTest: QuickSpec {
    override func spec() {
        it("has a SLVariable type") {
            let cell = SLVariableTableViewCell(style: .Default, reuseIdentifier: nil)
            expect(cell.type) == BlockType.SLVariable
        }
    }
}

class SLEndTableViewCellTest: QuickSpec {
    override func spec() {
        it("has a SLEnd type") {
            let cell = SLEndTableViewCell(style: .Default, reuseIdentifier: nil)
            expect(cell.type) == BlockType.SLEnd
        }
    }
}

class SLPrintTableViewCellTest: QuickSpec {
    override func spec() {
        it("has a SLPrint type") {
            let cell = SLPrintTableViewCell(style: .Default, reuseIdentifier: nil)
            expect(cell.type) == BlockType.SLPrint
        }
    }
}

class SLRepeatTableViewCellTest: QuickSpec {
    override func spec() {
        it("has a SLRepeat type") {
            let cell = SLRepeatTableViewCell(style: .Default, reuseIdentifier: nil)
            expect(cell.type) == BlockType.SLRepeat
        }
    }
}

class SLIfTableViewCellTest: QuickSpec {
    override func spec() {
        it("has a SLIf type") {
            let cell = SLIfTableViewCell(style: .Default, reuseIdentifier: nil)
            expect(cell.type) == BlockType.SLIf
        }
    }
}

class SLElseTableViewCellTest: QuickSpec {
    override func spec() {
        it("has a SLElse type") {
            let cell = SLElseTableViewCell(style: .Default, reuseIdentifier: nil)
            expect(cell.type) == BlockType.SLElse
        }
    }
}



