<?php
if (!defined('_PS_VERSION_'))
  exit;

require_once(dirname(__FILE__) . '/classes/customFeatured.php');

use PrestaShop\PrestaShop\Adapter\Image\ImageRetriever;
use PrestaShop\PrestaShop\Adapter\Product\PriceFormatter;
use PrestaShop\PrestaShop\Core\Product\ProductListingPresenter;
use PrestaShop\PrestaShop\Adapter\Product\ProductColorsRetriever;

class mpm_customfeatured extends Module
{
  private $_homeFeatured;
  private $_idShop;
  private $_idLang;

  public function __construct()
  {
    $this->name = 'mpm_customfeatured';
    $this->tab = 'front_office_features';
    $this->version = '1.0.1';
    $this->author = 'MyPrestaModules';
    $this->need_instance = 0;
    $this->bootstrap = true;

    parent::__construct();

    $this->displayName = $this->l('Custom featured');
    $this->description = $this->l('Custom featured');
    $this->_homeFeatured = new customFeatured();
    $this->_idShop = Context::getContext()->shop->id;
    $this->_idLang = Context::getContext()->language->id;
  }

  public function install()
  {
    if (!parent::install()
      || !$this->registerHook('header')
        || !$this->registerHook('actionAdminControllerSetMedia')
      || !$this->registerhook('displayHomeContent1')
      || !$this->registerhook('displayHomeContent2')
      || !$this->registerhook('displayHomeContent3')
      || !$this->registerhook('displayHomeContent4')
      || !$this->registerhook('displayHomeContent5')
    )
      return false;

    $this->_createTab('AdminCustomFeatured', 'Home Featured');
    $this->_installDb();
    $this->_setDataDb();

    return true;
  }
  public function uninstall()
  {
    if (  !parent::uninstall()  )
      return false;

    $this->_removeTab('AdminCustomFeatured');
    $this->_uninstallDb();

    return true;
  }

    public function hookActionAdminControllerSetMedia()
    {
        if (Tools::getValue('controller') != 'AdminCustomFeatured') {
            return false;
        }

        $this->context->controller->addCSS([
            _PS_MODULE_DIR_.'mpm_customfeatured/views/css/mpm_customfeatured_admin.css'
        ]);

        $this->context->controller->addJS([
            _PS_MODULE_DIR_.'mpm_customfeatured/views/js/mpm_customfeatured_admin.js',
            __PS_BASE_URI__.'js/jquery/plugins/select2/jquery.select2.js'
        ]);
    }

  private function _createTab($class_name, $name)
  {
    $tab = new Tab();
    $tab->active = 1;
    $tab->class_name = $class_name;
    $tab->name = array();
    foreach (Language::getLanguages(true) as $lang)
      $tab->name[$lang['id_lang']] = $name;
    $tab->id_parent = -1;
    $tab->module = $this->name;
    $tab->add();
  }

  private function _removeTab($class_name)
  {
    $id_tab = (int)Tab::getIdFromClassName($class_name);
    if ($id_tab)
    {
      $tab = new Tab($id_tab);
      $tab->delete();
    }
  }

  private function _installDb()
  {
    // Table  pages
    $sql = 'DROP TABLE IF EXISTS ' . _DB_PREFIX_ . 'customfeatured';
    Db::getInstance()->execute($sql);

    $sql = 'CREATE TABLE IF NOT EXISTS ' . _DB_PREFIX_ . 'customfeatured(
				id_customfeatured int(11) unsigned NOT NULL AUTO_INCREMENT,
				active boolean NOT NULL,
				type varchar(255) NULL,
				position int(11) unsigned NOT NULL,
				ids_categories varchar(255) NULL,
				ids_products varchar(255) NULL,
				date_add datetime NULL,
				PRIMARY KEY (`id_customfeatured`)
				) ENGINE=InnoDB DEFAULT CHARSET=utf8';

    Db::getInstance()->execute($sql);

    // Table  pages lang
    $sql = 'DROP TABLE IF EXISTS ' . _DB_PREFIX_ . 'customfeatured_lang';
    Db::getInstance()->execute($sql);

    $sql = 'CREATE TABLE IF NOT EXISTS ' . _DB_PREFIX_ . 'customfeatured_lang(
				id_customfeatured int(11) unsigned NOT NULL,
				id_lang int(11) unsigned NOT NULL,
				id_shop int(11) unsigned NOT NULL,
				title varchar(255) NULL,
				PRIMARY KEY(id_customfeatured, id_shop, id_lang)
				) ENGINE=InnoDB DEFAULT CHARSET=utf8';
    Db::getInstance()->execute($sql);
  }

  private function _uninstallDb()
  {
    $sql = 'DROP TABLE IF EXISTS '._DB_PREFIX_.'customfeatured';
    Db::getInstance()->execute($sql);

    $sql = 'DROP TABLE IF EXISTS '._DB_PREFIX_.'customfeatured_lang';
    Db::getInstance()->execute($sql);
  }

  private function _setDataDb(){

    $data = array(
      array('type' => 'all', 'title' => 'Featured Products'),
      array('type' => 'all', 'title' => 'Our offers'),
      array('type' => 'new', 'title' => 'New products'),
    );

    foreach($data as $value){
      $this->_setItem($value['type'], $value['title'] );
    }
  }

  private function _setItem($type, $title){

    $languages = Language::getLanguages(false);
    $obj = new customFeatured();

    foreach ($languages as $lang){
      $obj->title[$lang['id_lang']] = $title;
    }

    $obj->type = $type;
    $obj->active = 1;
    $obj->save();
  }

  public function getContent()
  {
    Tools::redirectAdmin($this->context->link->getAdminLink('AdminCustomFeatured'));
  }

  public function hookDisplayHeader($params)
  {
    $this->context->controller->registerStylesheet('mpm_customfeatured', 'modules/'.$this->name.'/views/css/mpm_customfeatured.css',  array('media' => 'all', 'priority' => 900));
    $this->context->controller->registerStylesheet('slick', 'modules/'.$this->name.'/views/css/slick.css',  array('media' => 'all', 'priority' => 900));
    $this->context->controller->registerJavascript('mpm_customfeatured', 'modules/'.$this->name.'/views/js/mpm_customfeatured.js',  array('position' => 'bottom', 'priority' => 150));
    $this->context->controller->registerJavascript('slick', 'modules/'.$this->name.'/views/js/slick.min.js',  array('position' => 'bottom', 'priority' => 150));

    if( Context::getContext()->controller->php_self == 'product'){
      $id_product = (int)Tools::getValue('id_product');
      $productsViewed = (isset($params['cookie']->viewed) && !empty($params['cookie']->viewed)) ? array_slice(array_reverse(explode(',', $params['cookie']->viewed)), 0, 20) : array();
      if ($id_product && !in_array($id_product, $productsViewed))
      {
        $product = new Product((int)$id_product);
        if ($product->checkAccess((int)$this->context->customer->id))
        {
          if (isset($params['cookie']->viewed) && !empty($params['cookie']->viewed))
            $params['cookie']->viewed .= ','.(int)$id_product;
          else
            $params['cookie']->viewed = (int)$id_product;
        }
      }
    }
  }

  public function getProductsItem($value, $id_lang, $id_shop){
    $array_result = array();

    $ids = $this->getIdsProducts($value['type'], $value['ids_categories'], $value['ids_products']);

    if(!$ids){
      return false;
    }

    $products = $this->getProductsByIds($id_lang, $id_shop, $ids);

    $assembler = new ProductAssembler($this->context);
    $presenterFactory = new ProductPresenterFactory($this->context);
    $presentationSettings = $presenterFactory->getPresentationSettings();
    $presenter = new ProductListingPresenter(
      new ImageRetriever(
        $this->context->link
      ),
      $this->context->link,
      new PriceFormatter(),
      new ProductColorsRetriever(),
      $this->context->getTranslator()
    );

    $array_result = array();
    foreach ($products as $prow) {
      $array_result[] = $presenter->present(
        $presentationSettings,
        $assembler->assembleProduct($prow),
        $this->context->language
      );
    }

    return $array_result;
  }

  public function getIdsProducts($type, $categories, $products){

    $ids = false;

    if($type == 'all'){
      $ids = $this->getIdsAllProducts();
    }

    if($type == 'category'){
      if($categories){
        $ids = $this->getIdsProductsInCategory($categories);
      }
      else{
        $ids = false;
      }
    }

    if($type == 'products'){
      if($products){
        $ids = $products;
      }
      else{
        $ids = false;
      }
    }

    if($type == 'last_visited'){
      $ids = (isset(Context::getContext()->cookie->viewed) && !empty(Context::getContext()->cookie->viewed)) ? array_slice(array_reverse(explode(',', Context::getContext()->cookie->viewed)), 0, 40) : array();
      $ids = implode(',', $ids);

    }

    if($type == 'discount'){
      $ids = $this->getIdsProductsDiscount();
    }

    if($type == 'selling'){
      $ids = $this->getIdsProductsSale();
    }

    if($type == 'new'){
      $ids = $this->getIdsNewProducts();
    }

    return $ids;
  }



  public function getIdsAllProducts(){

    $sql = '
        SELECT GROUP_CONCAT( p.id_product ) as id_product
        FROM ' . _DB_PREFIX_ . 'product as p
        WHERE p.active = 1
        ';
    $res = Db::getInstance(_PS_USE_SQL_SLAVE_)->executeS($sql);

    if(isset($res[0]['id_product']) && $res[0]['id_product']){
      return $res[0]['id_product'];
    }
    else{
      return false;
    }
  }

  public function getIdsProductsInCategory($ids){

    $sql = '
        SELECT GROUP_CONCAT(DISTINCT cp.id_product ) as id_product
        FROM ' . _DB_PREFIX_ . 'category_product as cp
        INNER JOIN ' . _DB_PREFIX_ . 'product as p
        ON p.id_product = cp.id_product
        WHERE p.active = 1
        AND cp.id_category IN('.pSQL($ids).')
        ';

    $res = Db::getInstance(_PS_USE_SQL_SLAVE_)->executeS($sql);

    if(isset($res[0]['id_product']) && $res[0]['id_product']){
      return $res[0]['id_product'];
    }
    else{
      return false;
    }
  }



  public function getIdsProductsDiscount(){

    $sql = '
        SELECT GROUP_CONCAT( p.id_product ) as id_product
        FROM ' . _DB_PREFIX_ . 'product as p
        LEFT JOIN ' . _DB_PREFIX_ . 'specific_price as sp
        ON p.id_product = sp.id_product
        WHERE p.active = 1
         AND sp.id_specific_price IS NOT NULL
        ';
    $res = Db::getInstance(_PS_USE_SQL_SLAVE_)->executeS($sql);

    if(isset($res[0]['id_product']) && $res[0]['id_product']){
      return $res[0]['id_product'];
    }
    else{
      return false;
    }
  }

  public function getIdsProductsSale(){
    $sql = '
        SELECT GROUP_CONCAT( p.id_product ) as id_product
        FROM ' . _DB_PREFIX_ . 'product_sale as ps
        INNER JOIN ' . _DB_PREFIX_ . 'product as p
        ON p.id_product = ps.id_product
        WHERE p.active = 1
        ';
    $res = Db::getInstance(_PS_USE_SQL_SLAVE_)->executeS($sql);

    if(isset($res[0]['id_product']) && $res[0]['id_product']){
      return $res[0]['id_product'];
    }
    else{
      return false;
    }
  }

  public function getIdsNewProducts(){
    $sql = '
        SELECT GROUP_CONCAT(id_product) as id_product
        FROM(
        SELECT  ( p.id_product ) as id_product
        FROM ' . _DB_PREFIX_ . 'product as p
        WHERE p.active = 1
        ORDER BY p.date_add DESC
        ) as id_product
        ';

    $res = Db::getInstance(_PS_USE_SQL_SLAVE_)->executeS($sql);
    if(isset($res[0]['id_product']) && $res[0]['id_product']){
      return $res[0]['id_product'];
    }
    else{
      return false;
    }
  }

  public function getCategoriesFeatured($ids, $id_lang, $id_shop){
    $sql = '
           SELECT cp.id_category, cl.name, cl.link_rewrite, count(cp.id_category) as count_products
          FROM ' . _DB_PREFIX_ . 'category_product as cp
          INNER JOIN ' . _DB_PREFIX_ . 'category as c
          ON c.id_category = cp.id_category
          LEFT JOIN ' . _DB_PREFIX_ . 'category_lang as cl
          ON c.id_category = cl.id_category
          WHERE c.active = 1
          AND cl.id_shop = '.(int)$id_shop.'
          AND cl.id_lang = '.(int)$id_lang.'
          AND cp.id_product IN('.pSQL($ids).')
          AND cp.id_category != 2
          GROUP BY cp.id_category
        ';
    return Db::getInstance(_PS_USE_SQL_SLAVE_)->executeS($sql);
  }


  public function getProductsByIds($id_lang, $id_shop, $ids){


    $sql = '
			SELECT pl.name, p.*, i.id_image, pl.link_rewrite, p.reference
      FROM ' . _DB_PREFIX_ . 'product_lang as pl
      LEFT JOIN ' . _DB_PREFIX_ . 'image as i
      ON i.id_product = pl.id_product AND i.cover=1
      INNER JOIN ' . _DB_PREFIX_ . 'product as p
      ON p.id_product = pl.id_product
      LEFT JOIN ' . _DB_PREFIX_ . 'category_product as cp
      ON p.id_product = cp.id_product
      WHERE pl.id_lang = ' . (int)$id_lang . '
      AND pl.id_shop = ' . (int)$id_shop . '
      AND p.id_product IN ('.pSQL($ids).')
      GROUP BY p.id_product
      ORDER BY FIELD(p.id_product, '.pSQL($ids).')
      LIMIT 9
			';

    return Db::getInstance(_PS_USE_SQL_SLAVE_)->executeS($sql);
  }
  
  public function hookDisplayHomeContent3()
  {

    $settings = $this->_homeFeatured->getSetiingsItem($this->_idLang, $this->_idShop, false);
    if(!$settings || !isset($settings[0]) || !$settings[0]){
      return false;
    }

    $products = $this->getProductsItem($settings[0], $this->_idLang, $this->_idShop);
    if(!$products){
      return false;
    }

    if(!$settings){
      return false;
    }

    $this->context->smarty->assign(
      array(
        'tabs'     => $settings,
        'products' => $products,
        'id_shop'  => $this->_idShop,
        'id_lang'  => $this->_idLang,
        'basePath' => _PS_BASE_URL_SSL_ . __PS_BASE_URI__,
      )
    );

    return $this->display(__FILE__, 'views/templates/hook/itemSlider.tpl');
  }

}