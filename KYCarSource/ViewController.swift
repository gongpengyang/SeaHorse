//
//  ViewController.swift
//  HelloWorld
//
//  Created by gongpengyang on 2019/1/31.
//  Copyright © 2019 gongpengyang. All rights reserved.
//

import UIKit
import testA


class ViewController: UIViewController {
    
    lazy var m_addressSelectorView = { () -> KYAddressSelectorBackView in
        let view = KYAddressSelectorBackView.loadFromNib()
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "首页"
        // Do any additional setup after loading the view, typically from a nib.
//        self.view.addSubview(m_addressSelectorView())
    }
    
    @IBAction func showMessage(_ sender: Any) {
        
        
        /*
         只有一个选项的弹窗
         
         let alerVC = UIAlertController(title: "欢迎来到Swift~", message: "你好,龚鹏洋!", preferredStyle: UIAlertController.Style.alert) //actionSheet 从下往上弹出
         
         //alerVC.addAction 这里添加几个就是几个
         alerVC.addAction(UIAlertAction(title: "可以了", style: UIAlertAction.Style.cancel, handler: { (UIAlertAction) in
         //消失后回调
         print("ojbk 啦 !")
         }))
         //点击的时候调取
         self.present(alerVC, animated: true) {
         print("ojbk 啦 ! 然后呢~~~")
         }
         
         **/
        
//        let vc = DetailXIBVC(nibName: "DetailXIBVC", bundle: nil)
////        vc.avasset = asset
//        vc.delegate = self
//        self.navigationController?.pushViewController(vc, animated: true)
        

    
        
        
    }

    @IBAction func buttonClick(_ sender: Any) {
        //KYCarTypeVC KYCarSourceList
//        let vc = KYCarSourceList(nibName:"KYCarSourceList",bundle:nil)
//        vc.getCarDatasCallBack = {
//            (longs:Array<String>,types:Array<String>) -> ()in
//            print("车长:\(longs),车型:\(types)")
//
//        }

//        self.navigationController?.pushViewController(vc, animated: true)
//        m_addressSelectorView.show()
//        m_addressSelectorView.getAddressCallBack = {
//              (datas:Array<KYAddressModel>) -> ()in
//
//        }
        
        let vc  = OCController.init()
        self.navigationController?.pushViewController(vc, animated: true)
        
//        let name:A  = <#value#>
        
 
    }
    
    
    @IBAction func ocButtonClick(_ sender: Any) {
        let vc = KYCarTypeVC(nibName:"KYCarTypeVC",bundle:nil)
//        vc.isSupply = true
        vc.getCarDatasCallBack = {
            (longs:Array<String>,types:Array<String>) -> ()in
            print("车长:\(longs),车型:\(types)")
            
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}


//extension ViewController:DetailXIBVCDelegate {
//    func changeColor() {
//        view.backgroundColor = UIColor.red
//    }
//}
