
import Foundation
import SwiftUI

extension View {
    // Controls the application's preferred home indicator auto-hiding when this view is shown.
    func prefersHomeIndicatorAutoHidden(_ value: Bool) -> some View {
        preference(key: PreferenceUIHostingController.PrefersHomeIndicatorAutoHiddenPreferenceKey.self, value: value)
    }
    
    // Controls the application's preferred screen edges deferring system gestures when this view is shown. Default is UIRectEdgeNone.
    func edgesDeferringSystemGestures(_ edge: UIRectEdge) -> some View {
        preference(key: PreferenceUIHostingController.PreferredScreenEdgesDeferringSystemGesturesPreferenceKey.self, value: edge)
    }
    
}

class PreferenceUIHostingController: UIHostingController<AnyView> {
    init<V: View>(wrappedView: V) {
        let box = Box()
        super.init(rootView: AnyView(wrappedView
            .onPreferenceChange(PrefersHomeIndicatorAutoHiddenPreferenceKey.self) {
                box.value?._prefersHomeIndicatorAutoHidden = $0
            }
            .onPreferenceChange(PreferredScreenEdgesDeferringSystemGesturesPreferenceKey.self) {
                box.value?._preferredScreenEdgesDeferringSystemGestures = $0
            }
        ))
        box.value = self
    }

    @objc override dynamic var prefersStatusBarHidden: Bool { return true }
    
    @objc required dynamic init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private class Box {
        weak var value: PreferenceUIHostingController?
        init() {}
    }
    
    // MARK: Prefers Home Indicator Auto Hidden
    
    fileprivate struct PrefersHomeIndicatorAutoHiddenPreferenceKey: PreferenceKey {
        typealias Value = Bool
        
        static var defaultValue: Value = false
        
        static func reduce(value: inout Value, nextValue: () -> Value) {
            value = nextValue() || value
        }
    }
    
    private var _prefersHomeIndicatorAutoHidden = false {
        didSet { setNeedsUpdateOfHomeIndicatorAutoHidden() }
    }
    override var prefersHomeIndicatorAutoHidden: Bool {
        _prefersHomeIndicatorAutoHidden
    }
    
    // MARK: Preferred Screen Edges Deferring SystemGestures
    
    fileprivate struct PreferredScreenEdgesDeferringSystemGesturesPreferenceKey: PreferenceKey {
        typealias Value = UIRectEdge
        
        static var defaultValue: Value = []
        
        static func reduce(value: inout Value, nextValue: () -> Value) {
            value.formUnion(nextValue())
        }
    }
    
    private var _preferredScreenEdgesDeferringSystemGestures: UIRectEdge = [] {
        didSet { setNeedsUpdateOfScreenEdgesDeferringSystemGestures() }
    }
    override var preferredScreenEdgesDeferringSystemGestures: UIRectEdge {
        _preferredScreenEdgesDeferringSystemGestures
    }
}
