import Quick
import Nimble

class SLRepeatTableViewCellSpec: QuickSpec {
    override func spec() {
        describe("type") {
            it("is SLRepeat") {
                let cell = SLRepeatTableViewCell(style: .Default, reuseIdentifier: nil)
                expect(cell.type) == BlockType.SLRepeat
            }
        }
    }
}
