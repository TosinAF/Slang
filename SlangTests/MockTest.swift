import Quick
import Nimble


class SLVariableTableViewCellTest: QuickSpec {
    override func spec() {
        it("has a SLVariable type") {
            let cell = SLVariableTableViewCell(style: .Default, reuseIdentifier: nil)
            expect(cell.type).to(equal(BlockType.SLVariable))
        }
    }
}
