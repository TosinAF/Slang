import Quick
import Nimble

class SLIfTableViewCellSpec: QuickSpec {
    override func spec() {
        describe("type") {
            it("is SLIf") {
                let cell = SLIfTableViewCell(style: .Default, reuseIdentifier: nil)
                expect(cell.type) == BlockType.SLIf
            }
        }
    }
}
