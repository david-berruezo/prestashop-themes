<?php
if (!defined('_PS_VERSION_'))
  exit;

require_once(dirname(__FILE__) . '/classes/testimonials.php');


class mpm_testimonials extends Module
{

  private $_shopId;
  private $_langId;

  public function __construct()
  {
    $this->name = 'mpm_testimonials';
    $this->tab = 'front_office_features';
    $this->version = '1.0.1';
    $this->author = 'MyPrestaModules';
    $this->need_instance = 0;
    $this->ps_versions_compliancy = array('min' => '1.6', 'max' => _PS_VERSION_);
    $this->bootstrap = true;
    $this->module_key = '0920411ab0a254a68630f7a0559d3a82';

    parent::__construct();

    $this->_shopId = Context::getContext()->shop->id;
    $this->_langId = Context::getContext()->language->id;
    $this->displayName = $this->l('Testimonials on homepage');
    $this->description = $this->l('Testimonials block on homepage.');
    $this->confirmUninstall = $this->l('Are you sure you want to uninstall?');
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
      || !Configuration::updateValue('GOMAKOIL_TESTIMONIALS', 'displayHomeContent4')
    )
      return false;

    $this->_createTab();
    $this->installDb();
    $this->_setDataDb();

    return true;
  }

  public function uninstall()
  {
    if (!parent::uninstall())
      return false;

    $this->_removeTab();
    $this->uninstallDb();

    return true;
  }

    public function hookActionAdminControllerSetMedia()
    {
        if (Tools::getValue('controller') != 'AdminTestimonials') {
            return false;
        }

        $this->context->controller->addCSS([
            _PS_MODULE_DIR_.'mpm_testimonials/views/css/mpm_testimonials_admin.css'
        ]);

        $this->context->controller->addJS([
            _PS_MODULE_DIR_.'mpm_testimonials/views/js/mpm_testimonials_admin.js'
        ]);
    }

  private function uninstallDb()
  {
    $sql = 'DROP TABLE IF EXISTS '._DB_PREFIX_.'testimonials';
    Db::getInstance()->execute($sql);

    $sql = 'DROP TABLE IF EXISTS '._DB_PREFIX_.'testimonials_lang';
    Db::getInstance()->execute($sql);
  }

  private function _createTab()
  {
    $tab = new Tab();
    $tab->active = 1;
    $tab->class_name = 'AdminTestimonials';
    $tab->name = array();
    foreach (Language::getLanguages(true) as $lang)
      $tab->name[$lang['id_lang']] = 'Testimonials';
    $tab->id_parent = -1;
    $tab->module = $this->name;
    $tab->add();
  }

  private function _removeTab()
  {
    $id_tab = (int)Tab::getIdFromClassName('AdminTestimonials');
    if ($id_tab)
    {
      $tab = new Tab($id_tab);
      $tab->delete();
    }
  }


  public function installDb()
  {
    // Table  pages
    $sql = 'DROP TABLE IF EXISTS ' . _DB_PREFIX_ . 'testimonials';
    Db::getInstance()->execute($sql);

    $sql = 'CREATE TABLE IF NOT EXISTS ' . _DB_PREFIX_ . 'testimonials(
				id_testimonials int(11) unsigned NOT NULL AUTO_INCREMENT,
				active boolean NOT NULL,
				position int(11) unsigned NOT NULL,
			    date_add datetime NULL,
				PRIMARY KEY (`id_testimonials`)
				) ENGINE=InnoDB DEFAULT CHARSET=utf8';

    Db::getInstance()->execute($sql);

    // Table  pages lang
    $sql = 'DROP TABLE IF EXISTS ' . _DB_PREFIX_ . 'testimonials_lang';
    Db::getInstance()->execute($sql);

    $sql = 'CREATE TABLE IF NOT EXISTS ' . _DB_PREFIX_ . 'testimonials_lang(
				id_testimonials int(11) unsigned NOT NULL,
				id_lang int(11) unsigned NOT NULL,
				id_shop int(11) unsigned NOT NULL,
				title varchar(255) NOT NULL,
				description varchar(2000) NULL,
				PRIMARY KEY(id_testimonials, id_shop, id_lang)
				) ENGINE=InnoDB DEFAULT CHARSET=utf8';
    Db::getInstance()->execute($sql);

  }


  private function _setDataDb(){

    $descr = 'Cara Delevingne just launched her new handbags collection in collaboration with the renowned brand Mulberry. This collection is mostly about leather  Cara Delevingne just ';

    $data = array(
      array('title' => 'Jon Silver', 'description' => $descr),
      array('title' => 'Jon Silver', 'description' => $descr),
      array('title' => 'Jon Silver', 'description' => $descr),
      array('title' => 'Jon Silver', 'description' => $descr),
    );

    foreach($data as $value){
      $this->_setItem($value);
    }
  }


  private function _setItem($value){

    $languages = Language::getLanguages(false);
    $obj = new testimonials();

    foreach ($languages as $lang){
      $obj->title[$lang['id_lang']] = $value['title'];
      $obj->description[$lang['id_lang']] =  $value['description'];
    }
    $obj->active = 1;
    $obj->save();

  }


  public function getContent()
  {
    Tools::redirectAdmin($this->context->link->getAdminLink('AdminTestimonials'));
  }


  public function hookHeader() {

    $this->context->controller->registerStylesheet('mpm_testimonials', 'modules/'.$this->name.'/views/css/mpm_testimonials.css', array('media' => 'all', 'priority' => 900));
    $this->context->controller->registerJavascript('mpm_testimonials', 'modules/'.$this->name.'/views/js/mpm_testimonials.js',  array('position' => 'bottom', 'priority' => 150));
  }


  public function hookDisplayHomeContent1()
  {
    $hook = Configuration::get('GOMAKOIL_TESTIMONIALS');
    if(($hook !== 'displayHomeContent1')){
      return false;
    }
    $this->smarty->assign($this->getVariables());
    return $this->display(__FILE__, 'views/templates/hook/customblock.tpl');
  }

  public function hookDisplayHomeContent2()
  {
    $hook = Configuration::get('GOMAKOIL_TESTIMONIALS');
    if(($hook !== 'displayHomeContent2')){
      return false;
    }
    $this->smarty->assign($this->getVariables());
    return $this->display(__FILE__, 'views/templates/hook/customblock.tpl');
  }

  public function hookDisplayHomeContent3()
  {
    $hook = Configuration::get('GOMAKOIL_TESTIMONIALS');
    if(($hook !== 'displayHomeContent3')){
      return false;
    }
    $this->smarty->assign($this->getVariables());
    return $this->display(__FILE__, 'views/templates/hook/customblock.tpl');
  }

  public function hookDisplayHomeContent4()
  {
    $hook = Configuration::get('GOMAKOIL_TESTIMONIALS');
    if(($hook !== 'displayHomeContent4')){
      return false;
    }
    $this->smarty->assign($this->getVariables());
    return $this->display(__FILE__, 'views/templates/hook/customblock.tpl');
  }

  public function hookDisplayHomeContent5()
  {
    $hook = Configuration::get('GOMAKOIL_TESTIMONIALS');
    if(($hook !== 'displayHomeContent5')){
      return false;
    }
    $this->smarty->assign($this->getVariables());
    return $this->display(__FILE__, 'views/templates/hook/customblock.tpl');
  }

  public function getVariables()
  {
    $obj = new testimonials();
    $items = $obj->getCustomBlock($this->_langId, $this->_shopId);
    foreach ($items as $key => $item) {
      $items[$key]['image'] = (file_exists(_PS_MODULE_DIR_.'/mpm_testimonials/views/img/'.$item['id_testimonials'].'.png')) ? (_MODULE_DIR_.'mpm_testimonials/views/img/'.$item['id_testimonials'].'.png') : false;
    }
    return array(
      'id_shop' => $this->_shopId,
      'id_lang' => $this->_langId,
      'items'   => $items,
    );
  }

}