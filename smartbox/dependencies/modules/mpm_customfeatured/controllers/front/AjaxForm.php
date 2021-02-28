<?php
/**
 * Created by PhpStorm.
 * User: root
 * Date: 04.09.15
 * Time: 20:33
 */

require_once(dirname(__FILE__) . '/../../mpm_customfeatured.php');
require_once(dirname(__FILE__) . '/../../classes/customFeatured.php');

class mpm_customfeaturedAjaxFormModuleFrontController extends FrontController
{


  public function initContent()
  {
    if (!$this->ajax) {
      parent::initContent();
    }
  }

  public function displayAjax()
  {
     $json = array();
    try{

      if (Tools::getValue('action') == 'show'){

        $obj = new mpm_customfeatured();
        $obj_class = new customFeatured();

        $id = Tools::getValue('id');
        $id_lang = Tools::getValue('id_lang');
        $id_shop = Tools::getValue('id_shop');

        $settings = $obj_class->getSetiingsItem($id_lang, $id_shop, $id);
        if(!$settings || !isset($settings[0]) || !$settings[0]){
          return false;
        }

        $products = $obj->getProductsItem($settings[0], $id_lang, $id_shop);
        if(!$products){
          return false;
        }

        $json['form'] = $this->getContentTab($id_lang, $id_shop, $products);

      }

      die( Tools::jsonEncode($json) );
    }
    catch(Exception $e){
      $json['error'] = $e->getMessage();
      if( $e->getCode() == 10 ){
        $json['error_message'] = $e->getMessage();
      }
    }
    die( Tools::jsonEncode($json) );
  }



  public function getContentTab($id_lang, $id_shop, $products)
  {
    $data = Context::getContext()->smarty->createTemplate(_PS_MODULE_DIR_ . 'mpm_customfeatured/views/templates/hook/featured.tpl');


    $data->assign(
      array(
        'id_shop'           => $id_shop,
        'id_lang'           => $id_lang,
        'products'           => $products,
      )
    );
    return $data->fetch();
  }



}