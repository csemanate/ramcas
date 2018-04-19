/*
Navicat MySQL Data Transfer

Source Server         : WAMP root
Source Server Version : 50711
Source Host           : localhost:3306
Source Database       : ramcas

Target Server Type    : MYSQL
Target Server Version : 50711
File Encoding         : 65001

Date: 2018-04-18 10:21:39
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for archivo
-- ----------------------------
DROP TABLE IF EXISTS `archivo`;
CREATE TABLE `archivo` (
  `archivo_id` int(11) NOT NULL AUTO_INCREMENT,
  `ach_empresa_id` int(11) DEFAULT NULL,
  `ach_nombre` varchar(50) DEFAULT NULL,
  `ach_path` varchar(255) DEFAULT NULL,
  `ach_tab` int(4) DEFAULT NULL,
  `ach_activa` tinyint(1) DEFAULT NULL,
  `ach_usuario` varchar(50) DEFAULT NULL,
  `arch_notas` text,
  PRIMARY KEY (`archivo_id`),
  UNIQUE KEY `NR_ach_nombre` (`ach_nombre`) USING BTREE,
  UNIQUE KEY `NR_ach_nombre_ach_tab` (`ach_nombre`,`ach_tab`) USING BTREE,
  UNIQUE KEY `NR_ach_tab` (`ach_tab`) USING BTREE,
  KEY `FK_ach_empresa_id` (`ach_empresa_id`),
  CONSTRAINT `FK_ach_empresa_id` FOREIGN KEY (`ach_empresa_id`) REFERENCES `empresa` (`empresa_id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for archivobodegaperfil
-- ----------------------------
DROP TABLE IF EXISTS `archivobodegaperfil`;
CREATE TABLE `archivobodegaperfil` (
  `archivobodegaperfil_id` int(11) NOT NULL AUTO_INCREMENT,
  `abp_archivo_id` int(11) DEFAULT NULL,
  `abp_bodega_id` int(11) DEFAULT NULL,
  `abp_perfilreposicion_id` int(11) DEFAULT NULL,
  `abp_notas` text,
  PRIMARY KEY (`archivobodegaperfil_id`),
  UNIQUE KEY `IN_NoRepetidos` (`abp_archivo_id`,`abp_bodega_id`,`abp_perfilreposicion_id`) USING BTREE,
  KEY `FK_abp_bodega_id` (`abp_bodega_id`),
  KEY `FK_abp_perfilreposicion_id` (`abp_perfilreposicion_id`),
  CONSTRAINT `FK_abp_archivo_id` FOREIGN KEY (`abp_archivo_id`) REFERENCES `archivo` (`archivo_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_abp_bodega_id` FOREIGN KEY (`abp_bodega_id`) REFERENCES `bodega` (`bodega_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_abp_perfilreposicion_id` FOREIGN KEY (`abp_perfilreposicion_id`) REFERENCES `perfilreposicion` (`perfilreposicion_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=105 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for bodega
-- ----------------------------
DROP TABLE IF EXISTS `bodega`;
CREATE TABLE `bodega` (
  `bodega_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Identificador único de la bodega generado por el sistema',
  `bod_empresa_id` int(11) DEFAULT NULL COMMENT 'FK que define a qué empresa pertenece la bodega',
  `bod_pais_id` varchar(50) DEFAULT NULL COMMENT 'Define el país donde está la bodega',
  `bod_region_id` varchar(50) DEFAULT NULL COMMENT 'Define la región donde está la bodega',
  `bod_ciudad_id` varchar(50) DEFAULT NULL COMMENT 'Define la ciudad donde se encuentra la bodega',
  `bod_nivela_cceso_id` varchar(15) DEFAULT NULL,
  `bod_grupo_acceso_id` varchar(15) DEFAULT NULL,
  `bod_usuario_acceso_id` varchar(15) DEFAULT NULL,
  `bod_codigo` varchar(30) DEFAULT NULL COMMENT 'Código de la bodega que utiliza la empresa para identificarla',
  `bod_nombre` varchar(60) DEFAULT NULL COMMENT 'Nombre descriptivo de la bodega',
  `bod_es_planta` tinyint(1) DEFAULT '0' COMMENT 'Define si la bodega es una planta',
  `bod_maneja_inventario` tinyint(1) DEFAULT '1' COMMENT 'Define si la bodega maneja y repone inventario',
  `bod_tiene_reposicion` tinyint(1) DEFAULT '1' COMMENT 'Define si la bodega tiene reposiciones de inventario',
  `bod_maneja_exhibicion` tinyint(1) DEFAULT '0' COMMENT 'Identifica si la bodega maneja exhibición',
  `bod_tiene_facturacion` tinyint(1) DEFAULT '0' COMMENT 'Identifica si se puede hacer facturación desde la bodega',
  `bod_es_consignacion` tinyint(1) DEFAULT '0' COMMENT 'Identifica si la bodega es de consignación',
  `bod_es_proveedor` tinyint(1) DEFAULT '0' COMMENT 'Define si la bodega es proveedor de inventario',
  `bod_tipo_reposicion` char(3) DEFAULT '0' COMMENT 'Define el tipo de reposición de la bodega',
  `bod_es_propia` tinyint(1) DEFAULT '1' COMMENT 'Define si la bodega es propia o de otra empresa',
  `bod_transito_propio` tinyint(1) DEFAULT '1' COMMENT 'Define si recibe tránsito del sistema ERP.',
  `bod_transito_externo` tinyint(1) DEFAULT '1' COMMENT 'Define si la bodega maneja transito que viene del sistema de transferencias de RAMCAS.',
  `bod_transferencia_batch` tinyint(1) DEFAULT NULL,
  `bod_activa` tinyint(1) DEFAULT '1' COMMENT 'Define si la bodega está activa o no',
  `bod_usuario` varchar(50) DEFAULT NULL,
  `bod_notas` text,
  PRIMARY KEY (`bodega_id`),
  UNIQUE KEY `NR_codigo_bodega_empresa` (`bod_empresa_id`,`bod_codigo`,`bod_nombre`) USING BTREE,
  KEY `FK_bod_empresa_id` (`bod_empresa_id`),
  CONSTRAINT `FK_bod_empresa_id` FOREIGN KEY (`bod_empresa_id`) REFERENCES `empresa` (`empresa_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=819 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for bodegaadyacente
-- ----------------------------
DROP TABLE IF EXISTS `bodegaadyacente`;
CREATE TABLE `bodegaadyacente` (
  `bodegaadyacente_id` int(11) NOT NULL AUTO_INCREMENT,
  `ady_bodega1_id` varchar(15) DEFAULT NULL COMMENT 'Identificador de la bodega 1 adyacente a la 2',
  `ady_bodega2_id` varchar(15) DEFAULT NULL COMMENT 'Identificador de la bodega 2 adyacente a la 1',
  PRIMARY KEY (`bodegaadyacente_id`),
  KEY `FK_ady_bodega1_id` (`ady_bodega1_id`),
  KEY `FK_ady_bodega2_id` (`ady_bodega2_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for bodegaproveedor
-- ----------------------------
DROP TABLE IF EXISTS `bodegaproveedor`;
CREATE TABLE `bodegaproveedor` (
  `bodegaproveedor_id` int(11) NOT NULL AUTO_INCREMENT,
  `bop_bodega_id` int(11) DEFAULT NULL,
  `bop_proveedor_id` int(11) DEFAULT NULL,
  `bop_prioridad` tinyint(2) NOT NULL,
  PRIMARY KEY (`bodegaproveedor_id`),
  UNIQUE KEY `IN_NoRepetidos1` (`bop_bodega_id`,`bop_prioridad`) USING BTREE,
  UNIQUE KEY `IN_NoRepetidos2` (`bop_bodega_id`,`bop_proveedor_id`) USING BTREE,
  KEY `FK_bop_proveedor_id` (`bop_proveedor_id`),
  CONSTRAINT `FK_bop_bodega_id` FOREIGN KEY (`bop_bodega_id`) REFERENCES `bodega` (`bodega_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_bop_proveedor_id` FOREIGN KEY (`bop_proveedor_id`) REFERENCES `proveedor` (`proveedor_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=156 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for bodega_sl
-- ----------------------------
DROP TABLE IF EXISTS `bodega_sl`;
CREATE TABLE `bodega_sl` (
  `bodega_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Identificador único de la bodega generado por el sistema',
  `bod_empresa_id` int(11) DEFAULT NULL COMMENT 'FK que define a qué empresa pertenece la bodega',
  `bod_pais_id` varchar(50) DEFAULT NULL COMMENT 'Define el país donde está la bodega',
  `bod_region_id` varchar(50) DEFAULT NULL COMMENT 'Define la región donde está la bodega',
  `bod_ciudad_id` varchar(50) DEFAULT NULL COMMENT 'Define la ciudad donde se encuentra la bodega',
  `bod_nivelacceso_id` varchar(15) DEFAULT NULL,
  `bod_grupoacceso_id` varchar(15) DEFAULT NULL,
  `bod_usuarioacceso_id` varchar(15) DEFAULT NULL,
  `bod_codigo` varchar(15) DEFAULT NULL COMMENT 'Código de la bodega que utiliza la empresa para identificarla',
  `bod_nombre` varchar(40) DEFAULT NULL COMMENT 'Nombre descriptivo de la bodega',
  `bod_activa` tinyint(1) DEFAULT '1' COMMENT 'Define si la bodega está activa o no',
  `bod_esplanta` tinyint(1) DEFAULT '0' COMMENT 'Define si la bodega es una planta',
  `bod_manejainventario` tinyint(1) DEFAULT '1' COMMENT 'Define si la bodega maneja y repone inventario',
  `bod_tienereposicion` tinyint(1) DEFAULT '1' COMMENT 'Define si la bodega tiene reposiciones de inventario',
  `bod_manejaexhibicion` tinyint(1) DEFAULT '0' COMMENT 'Identifica si la bodega maneja exhibición',
  `bod_tienefacturacion` tinyint(1) DEFAULT '0' COMMENT 'Identifica si se puede hacer facturación desde la bodega',
  `bod_esconsignacion` tinyint(1) DEFAULT '0' COMMENT 'Identifica si la bodega es de consignación',
  `bod_esproveedor` tinyint(1) DEFAULT '0' COMMENT 'Define si la bodega es proveedor de inventario',
  `bod_tiporeposicion` char(3) DEFAULT '0' COMMENT 'Define el tipo de reposición de la bodega',
  `bod_espropia` tinyint(1) DEFAULT '1' COMMENT 'Define si la bodega es propia o de otra empresa',
  `bod_transitopropio` tinyint(1) DEFAULT '1' COMMENT 'Define si recibe tránsito del sistema ERP.',
  `bod_transitoexterno` tinyint(1) DEFAULT '1' COMMENT 'Define si la bodega maneja transito que viene del sistema de transferencias de RAMCAS.',
  `bod_transferencia_batch` tinyint(1) DEFAULT NULL,
  `bod_notas` text,
  PRIMARY KEY (`bodega_id`),
  UNIQUE KEY `IN_bod_nombre` (`bod_nombre`) USING BTREE,
  KEY `FK_bod_empresa_id` (`bod_empresa_id`) USING BTREE,
  CONSTRAINT `bodega_sl_ibfk_1` FOREIGN KEY (`bod_empresa_id`) REFERENCES `empresa` (`empresa_id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for buffers
-- ----------------------------
DROP TABLE IF EXISTS `buffers`;
CREATE TABLE `buffers` (
  `buffer_id` int(11) NOT NULL AUTO_INCREMENT,
  `buf_bodega_id` int(11) DEFAULT NULL COMMENT 'BODEGA',
  `buf_codigo_id` int(11) DEFAULT NULL COMMENT 'CODIGO',
  `buf_codigo_funcional` int(11) DEFAULT NULL COMMENT 'CODIGO FUNCIONAL',
  `buf_codigo_vinculado` int(11) DEFAULT NULL COMMENT 'CODIGO VINCULADO',
  `buf_codigo_generico` int(11) DEFAULT NULL COMMENT 'CODIGO GENERICO',
  `buf_descripcion` varchar(255) DEFAULT NULL COMMENT 'DESCRIPCION',
  `buf_cod_grupo` varchar(255) DEFAULT NULL,
  `buf_grupo` varchar(255) DEFAULT NULL,
  `buf_cod_linea` varchar(255) DEFAULT NULL,
  `buf_linea` varchar(255) DEFAULT NULL,
  `buf_cod_sublinea` varchar(255) DEFAULT NULL,
  `buf_sublinea` varchar(255) DEFAULT NULL,
  `buf_cod_familia` varchar(255) DEFAULT NULL,
  `buf_familia` varchar(255) DEFAULT NULL,
  `buf_cod_subfamilia` varchar(255) DEFAULT NULL,
  `buf_subfamilia` varchar(255) DEFAULT NULL,
  `buf_cod_categoria` varchar(255) DEFAULT NULL,
  `buf_categoria` varchar(255) DEFAULT NULL,
  `buf_cod_tipo` varchar(255) DEFAULT NULL,
  `buf_tipo` varchar(255) DEFAULT NULL,
  `buf_cod_marca` varchar(255) DEFAULT NULL,
  `buf_marca` varchar(255) DEFAULT NULL,
  `buf_cod_modelo` varchar(255) DEFAULT NULL,
  `buf_modelo` varchar(255) DEFAULT NULL,
  `buf_cod_cat_management` varchar(255) DEFAULT NULL,
  `buf_cat_management` varchar(255) DEFAULT NULL,
  `buf_cod_cat_propia1` varchar(255) DEFAULT NULL,
  `buf_cat_propia1` varchar(255) DEFAULT NULL,
  `buf_cod_cat_propia2` varchar(255) DEFAULT NULL,
  `buf_cat_propia2` varchar(255) DEFAULT NULL,
  `buf_cod_cat_propia3` varchar(255) DEFAULT NULL,
  `buf_cat_propia3` varchar(255) DEFAULT NULL,
  `buf_cod_cat_propia4` varchar(255) DEFAULT NULL,
  `buf_cat_propia4` varchar(255) DEFAULT NULL,
  `buf_cod_cat_propia5` varchar(255) DEFAULT NULL,
  `buf_cat_propia5` varchar(255) DEFAULT NULL,
  `buf_ctv` decimal(12,2) DEFAULT NULL,
  `buf_pv` decimal(12,2) DEFAULT NULL,
  `buf_proveedor` varchar(255) DEFAULT NULL,
  `buf_perfil` varchar(255) DEFAULT NULL,
  `buf_horizonte` decimal(12,2) DEFAULT NULL,
  `buf_tiempo_suministro` decimal(12,2) DEFAULT NULL,
  `buf_tiempo_entre_pedidos` decimal(12,2) DEFAULT NULL,
  `buf_observaciones` varchar(255) DEFAULT NULL,
  `buf_gdb` tinyint(1) DEFAULT NULL,
  `buf_cam` tinyint(1) DEFAULT NULL,
  `buf_nuevo_buffer_ingles` decimal(12,0) DEFAULT NULL,
  `buf_nuevo_buffer_espanol` decimal(12,2) DEFAULT NULL,
  `buf_nuevo_buffer_sugerido` decimal(12,2) DEFAULT NULL,
  `buf_consumo` decimal(12,2) DEFAULT NULL,
  `buf_buffer_calculado` decimal(12,2) DEFAULT NULL,
  `buf_nuevo_buffer_real` decimal(12,2) DEFAULT NULL,
  `buf_buffer_minimo` decimal(12,2) DEFAULT NULL,
  `buf_pedido_minimo` decimal(12,2) DEFAULT NULL,
  `buf_unidad_empaque` decimal(12,2) DEFAULT NULL,
  `buf_porcentaje_atencion` decimal(4,2) DEFAULT NULL,
  `buf_impacto_faltante` varchar(255) DEFAULT NULL,
  `buf_buffer_actual` decimal(12,2) DEFAULT NULL,
  `buf_zona_amarilla` decimal(12,2) DEFAULT NULL,
  `buf_zona_roja` decimal(12,2) DEFAULT NULL,
  `buf_color` char(1) DEFAULT NULL,
  `buf_color1` char(1) DEFAULT NULL,
  `buf_ultimo_buffer` decimal(12,2) DEFAULT NULL,
  `buf_anterior_estacion` decimal(12,2) DEFAULT NULL,
  `buf_buffer_estacional` decimal(12,2) DEFAULT NULL,
  `buf_inventario_proveedor` decimal(12,2) DEFAULT NULL,
  `buf_inventario_fisico` decimal(12,2) DEFAULT NULL,
  `buf_estado_buffer` decimal(12,2) DEFAULT NULL,
  `buf_transito` decimal(12,2) DEFAULT NULL,
  `buf_comprometido` decimal(12,2) DEFAULT NULL,
  `buf_backorder` decimal(12,2) DEFAULT NULL,
  `buf_inventario_proyectado` decimal(12,2) DEFAULT NULL,
  `buf_requerimiento` decimal(12,2) DEFAULT NULL,
  `buf_pedido_promedio` decimal(12,2) DEFAULT NULL,
  `buf_pedido_real` decimal(12,2) DEFAULT NULL,
  `buf_calendario_estacional` varchar(255) DEFAULT NULL,
  `buf_accion_estacional` varchar(255) DEFAULT NULL,
  `buf_valor_dolar_dia` decimal(12,2) DEFAULT NULL,
  `buf_inventario_dolar_dia` decimal(12,2) DEFAULT NULL,
  `buf_rentabilidad` decimal(12,2) DEFAULT NULL,
  `buf_velocity` decimal(12,2) DEFAULT NULL,
  `buf_servicio` decimal(12,2) DEFAULT NULL,
  `buf_ultimo_cambio_buffer` date DEFAULT NULL,
  `buf_nuevo_inicio` date DEFAULT NULL,
  `buf_inicio_horizonte` date DEFAULT NULL,
  `buf_fin_horizonte` date DEFAULT NULL,
  `buf_variabilidad` decimal(12,2) DEFAULT NULL,
  `buf_porcentaje_lleno` decimal(12,2) DEFAULT NULL,
  `buf_rojo_acumulado` decimal(12,2) DEFAULT NULL,
  `buf_negro` decimal(12,2) DEFAULT NULL,
  `buf_rojo` decimal(12,2) DEFAULT NULL,
  `buf_amarillo` decimal(12,2) DEFAULT NULL,
  `buf_verde` decimal(12,2) DEFAULT NULL,
  `buf_lila` decimal(12,2) DEFAULT NULL,
  PRIMARY KEY (`buffer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for buffer_general
-- ----------------------------
DROP TABLE IF EXISTS `buffer_general`;
CREATE TABLE `buffer_general` (
  `buffer_id` int(11) NOT NULL AUTO_INCREMENT,
  `buf_empresa_id` int(11) DEFAULT NULL,
  `buf_bodega_id` int(11) DEFAULT NULL COMMENT 'BODEGA',
  `buf_codigo_id` int(11) DEFAULT NULL COMMENT 'CODIGO',
  `buf_codigo_funcional` int(11) DEFAULT NULL COMMENT 'CODIGO FUNCIONAL',
  `buf_codigo_vinculado` int(11) DEFAULT NULL COMMENT 'CODIGO VINCULADO',
  `buf_codigo_generico` int(11) DEFAULT NULL COMMENT 'CODIGO GENERICO',
  `buf_descripcion` varchar(255) DEFAULT NULL COMMENT 'DESCRIPCION',
  `buf_cod_grupo` varchar(255) DEFAULT NULL,
  `buf_grupo` varchar(255) DEFAULT NULL,
  `buf_cod_linea` varchar(255) DEFAULT NULL,
  `buf_linea` varchar(255) DEFAULT NULL,
  `buf_cod_sublinea` varchar(255) DEFAULT NULL,
  `buf_sublinea` varchar(255) DEFAULT NULL,
  `buf_cod_familia` varchar(255) DEFAULT NULL,
  `buf_familia` varchar(255) DEFAULT NULL,
  `buf_cod_subfamilia` varchar(255) DEFAULT NULL,
  `buf_subfamilia` varchar(255) DEFAULT NULL,
  `buf_cod_categoria` varchar(255) DEFAULT NULL,
  `buf_categoria` varchar(255) DEFAULT NULL,
  `buf_cod_tipo` varchar(255) DEFAULT NULL,
  `buf_tipo` varchar(255) DEFAULT NULL,
  `buf_cod_marca` varchar(255) DEFAULT NULL,
  `buf_marca` varchar(255) DEFAULT NULL,
  `buf_cod_modelo` varchar(255) DEFAULT NULL,
  `buf_modelo` varchar(255) DEFAULT NULL,
  `buf_cod_cat_management` varchar(255) DEFAULT NULL,
  `buf_cat_management` varchar(255) DEFAULT NULL,
  `buf_cod_cat_propia1` varchar(255) DEFAULT NULL,
  `buf_cat_propia1` varchar(255) DEFAULT NULL,
  `buf_cod_cat_propia2` varchar(255) DEFAULT NULL,
  `buf_cat_propia2` varchar(255) DEFAULT NULL,
  `buf_cod_cat_propia3` varchar(255) DEFAULT NULL,
  `buf_cat_propia3` varchar(255) DEFAULT NULL,
  `buf_cod_cat_propia4` varchar(255) DEFAULT NULL,
  `buf_cat_propia4` varchar(255) DEFAULT NULL,
  `buf_cod_cat_propia5` varchar(255) DEFAULT NULL,
  `buf_cat_propia5` varchar(255) DEFAULT NULL,
  `buf_ctv` decimal(10,2) DEFAULT NULL,
  `buf_pv` decimal(10,2) DEFAULT NULL,
  `buf_proveedor` varchar(255) DEFAULT NULL,
  `buf_perfil` varchar(255) DEFAULT NULL,
  `buf_horizonte` decimal(12,2) DEFAULT NULL,
  `buf_tiempo_suministro` decimal(12,2) DEFAULT NULL,
  `buf_tiempo_entre_pedidos` decimal(12,2) DEFAULT NULL,
  `buf_observaciones` varchar(255) DEFAULT NULL,
  `buf_gdb` tinyint(1) DEFAULT NULL,
  `buf_cam` tinyint(1) DEFAULT NULL,
  `buf_nuevo_buffer_ingles` decimal(12,0) DEFAULT NULL,
  `buf_nuevo_buffer_espanol` decimal(12,2) DEFAULT NULL,
  `buf_nuevo_buffer_sugerido` decimal(12,2) DEFAULT NULL,
  `buf_consumo` decimal(12,2) DEFAULT NULL,
  `buf_buffer_calculado` decimal(12,2) DEFAULT NULL,
  `buf_nuevo_buffer_real` decimal(12,2) DEFAULT NULL,
  `buf_buffer_minimo` decimal(12,2) DEFAULT NULL,
  `buf_pedido_minimo` decimal(12,2) DEFAULT NULL,
  `buf_unidad_empaque` decimal(12,2) DEFAULT NULL,
  `buf_porcentaje_atencion` decimal(4,2) DEFAULT NULL,
  `buf_impacto_faltante` varchar(255) DEFAULT NULL,
  `buf_buffer_actual` decimal(12,2) DEFAULT NULL,
  `buf_zona_amarilla` decimal(12,2) DEFAULT NULL,
  `buf_zona_roja` decimal(12,2) DEFAULT NULL,
  `buf_color` char(1) DEFAULT NULL,
  `buf_color1` char(1) DEFAULT NULL,
  `buf_ultimo_buffer` decimal(12,2) DEFAULT NULL,
  `buf_anterior_estacion` decimal(12,2) DEFAULT NULL,
  `buf_buffer_estacional` decimal(12,2) DEFAULT NULL,
  `buf_inventario_proveedor` decimal(12,2) DEFAULT NULL,
  `buf_inventario_fisico` decimal(12,2) DEFAULT NULL,
  `buf_estado_buffer` decimal(12,2) DEFAULT NULL,
  `buf_transito` decimal(12,2) DEFAULT NULL,
  `buf_comprometido` decimal(12,2) DEFAULT NULL,
  `buf_backorder` decimal(12,2) DEFAULT NULL,
  `buf_inventario_proyectado` decimal(12,2) DEFAULT NULL,
  `buf_requerimiento` decimal(12,2) DEFAULT NULL,
  `buf_pedido_promedio` decimal(12,2) DEFAULT NULL,
  `buf_pedido_real` decimal(12,2) DEFAULT NULL,
  `buf_calendario_estacional` varchar(255) DEFAULT NULL,
  `buf_accion_estacional` varchar(255) DEFAULT NULL,
  `buf_valor_dolar_dia` decimal(12,2) DEFAULT NULL,
  `buf_inventario_dolar_dia` decimal(12,2) DEFAULT NULL,
  `buf_rentabilidad` decimal(12,2) DEFAULT NULL,
  `buf_velocity` decimal(12,2) DEFAULT NULL,
  `buf_servicio` decimal(12,2) DEFAULT NULL,
  `buf_ultimo_cambio_buffer` date DEFAULT NULL,
  `buf_nuevo_inicio` date DEFAULT NULL,
  `buf_inicio_horizonte` date DEFAULT NULL,
  `buf_fin_horizonte` date DEFAULT NULL,
  `buf_variabilidad` decimal(12,2) DEFAULT NULL,
  `buf_porcentaje_lleno` decimal(12,2) DEFAULT NULL,
  `buf_rojo_acumulado` decimal(12,2) DEFAULT NULL,
  `buf_negro` decimal(12,2) DEFAULT NULL,
  `buf_rojo` decimal(12,2) DEFAULT NULL,
  `buf_amarillo` decimal(12,2) DEFAULT NULL,
  `buf_verde` decimal(12,2) DEFAULT NULL,
  `buf_lila` decimal(12,2) DEFAULT NULL,
  PRIMARY KEY (`buffer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for buffer_hcb
-- ----------------------------
DROP TABLE IF EXISTS `buffer_hcb`;
CREATE TABLE `buffer_hcb` (
  `buffer_id` int(11) NOT NULL AUTO_INCREMENT,
  `buf_empresa_id` int(11) DEFAULT NULL,
  `buf_bodega_id` int(11) DEFAULT NULL COMMENT 'BODEGA',
  `buf_codigo_id` int(11) DEFAULT NULL COMMENT 'CODIGO',
  `buf_codigo_funcional` int(11) DEFAULT NULL COMMENT 'CODIGO FUNCIONAL',
  `buf_codigo_vinculado` int(11) DEFAULT NULL COMMENT 'CODIGO VINCULADO',
  `buf_codigo_generico` int(11) DEFAULT NULL COMMENT 'CODIGO GENERICO',
  `buf_descripcion` varchar(255) DEFAULT NULL COMMENT 'DESCRIPCION',
  `buf_cod_grupo` varchar(255) DEFAULT NULL,
  `buf_grupo` varchar(255) DEFAULT NULL,
  `buf_cod_linea` varchar(255) DEFAULT NULL,
  `buf_linea` varchar(255) DEFAULT NULL,
  `buf_cod_sublinea` varchar(255) DEFAULT NULL,
  `buf_sublinea` varchar(255) DEFAULT NULL,
  `buf_cod_familia` varchar(255) DEFAULT NULL,
  `buf_familia` varchar(255) DEFAULT NULL,
  `buf_cod_subfamilia` varchar(255) DEFAULT NULL,
  `buf_subfamilia` varchar(255) DEFAULT NULL,
  `buf_cod_categoria` varchar(255) DEFAULT NULL,
  `buf_categoria` varchar(255) DEFAULT NULL,
  `buf_cod_tipo` varchar(255) DEFAULT NULL,
  `buf_tipo` varchar(255) DEFAULT NULL,
  `buf_cod_marca` varchar(255) DEFAULT NULL,
  `buf_marca` varchar(255) DEFAULT NULL,
  `buf_cod_modelo` varchar(255) DEFAULT NULL,
  `buf_modelo` varchar(255) DEFAULT NULL,
  `buf_cod_cat_management` varchar(255) DEFAULT NULL,
  `buf_cat_management` varchar(255) DEFAULT NULL,
  `buf_cod_cat_propia1` varchar(255) DEFAULT NULL,
  `buf_cat_propia1` varchar(255) DEFAULT NULL,
  `buf_cod_cat_propia2` varchar(255) DEFAULT NULL,
  `buf_cat_propia2` varchar(255) DEFAULT NULL,
  `buf_cod_cat_propia3` varchar(255) DEFAULT NULL,
  `buf_cat_propia3` varchar(255) DEFAULT NULL,
  `buf_cod_cat_propia4` varchar(255) DEFAULT NULL,
  `buf_cat_propia4` varchar(255) DEFAULT NULL,
  `buf_cod_cat_propia5` varchar(255) DEFAULT NULL,
  `buf_cat_propia5` varchar(255) DEFAULT NULL,
  `buf_ctv` decimal(12,2) DEFAULT NULL,
  `buf_pv` decimal(12,2) DEFAULT NULL,
  `buf_proveedor` varchar(255) DEFAULT NULL,
  `buf_perfil` varchar(255) DEFAULT NULL,
  `buf_horizonte` decimal(12,2) DEFAULT NULL,
  `buf_tiempo_suministro` decimal(12,2) DEFAULT NULL,
  `buf_tiempo_entre_pedidos` decimal(12,2) DEFAULT NULL,
  `buf_observaciones` varchar(255) DEFAULT NULL,
  `buf_gdb` tinyint(1) DEFAULT NULL,
  `buf_cam` tinyint(1) DEFAULT NULL,
  `buf_nuevo_buffer_ingles` decimal(12,0) DEFAULT NULL,
  `buf_nuevo_buffer_espanol` decimal(12,2) DEFAULT NULL,
  `buf_nuevo_buffer_sugerido` decimal(12,2) DEFAULT NULL,
  `buf_consumo` decimal(12,2) DEFAULT NULL,
  `buf_buffer_calculado` decimal(12,2) DEFAULT NULL,
  `buf_nuevo_buffer_real` decimal(12,2) DEFAULT NULL,
  `buf_buffer_minimo` decimal(12,2) DEFAULT NULL,
  `buf_pedido_minimo` decimal(12,2) DEFAULT NULL,
  `buf_unidad_empaque` decimal(12,2) DEFAULT NULL,
  `buf_porcentaje_atencion` decimal(4,2) DEFAULT NULL,
  `buf_impacto_faltante` varchar(255) DEFAULT NULL,
  `buf_buffer_actual` decimal(12,2) DEFAULT NULL,
  `buf_zona_amarilla` decimal(12,2) DEFAULT NULL,
  `buf_zona_roja` decimal(12,2) DEFAULT NULL,
  `buf_color` char(1) DEFAULT NULL,
  `buf_color1` char(1) DEFAULT NULL,
  `buf_ultimo_buffer` decimal(12,2) DEFAULT NULL,
  `buf_anterior_estacion` decimal(12,2) DEFAULT NULL,
  `buf_buffer_estacional` decimal(12,2) DEFAULT NULL,
  `buf_inventario_proveedor` decimal(12,2) DEFAULT NULL,
  `buf_inventario_fisico` decimal(12,2) DEFAULT NULL,
  `buf_estado_buffer` decimal(12,2) DEFAULT NULL,
  `buf_transito` decimal(12,2) DEFAULT NULL,
  `buf_comprometido` decimal(12,2) DEFAULT NULL,
  `buf_backorder` decimal(12,2) DEFAULT NULL,
  `buf_inventario_proyectado` decimal(12,2) DEFAULT NULL,
  `buf_requerimiento` decimal(12,2) DEFAULT NULL,
  `buf_pedido_promedio` decimal(12,2) DEFAULT NULL,
  `buf_pedido_real` decimal(12,2) DEFAULT NULL,
  `buf_calendario_estacional` varchar(255) DEFAULT NULL,
  `buf_accion_estacional` varchar(255) DEFAULT NULL,
  `buf_valor_dolar_dia` decimal(12,2) DEFAULT NULL,
  `buf_inventario_dolar_dia` decimal(12,2) DEFAULT NULL,
  `buf_rentabilidad` decimal(12,2) DEFAULT NULL,
  `buf_velocity` decimal(12,2) DEFAULT NULL,
  `buf_servicio` decimal(12,2) DEFAULT NULL,
  `buf_ultimo_cambio_buffer` date DEFAULT NULL,
  `buf_nuevo_inicio` date DEFAULT NULL,
  `buf_inicio_horizonte` date DEFAULT NULL,
  `buf_fin_horizonte` date DEFAULT NULL,
  `buf_variabilidad` decimal(12,2) DEFAULT NULL,
  `buf_porcentaje_lleno` decimal(12,2) DEFAULT NULL,
  `buf_rojo_acumulado` decimal(12,2) DEFAULT NULL,
  `buf_negro` decimal(12,2) DEFAULT NULL,
  `buf_rojo` decimal(12,2) DEFAULT NULL,
  `buf_amarillo` decimal(12,2) DEFAULT NULL,
  `buf_verde` decimal(12,2) DEFAULT NULL,
  `buf_lila` decimal(12,2) DEFAULT NULL,
  PRIMARY KEY (`buffer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for buffer_hist
-- ----------------------------
DROP TABLE IF EXISTS `buffer_hist`;
CREATE TABLE `buffer_hist` (
  `buffer_hist_id` int(11) NOT NULL,
  `buh_empresa` varchar(15) NOT NULL COMMENT 'C',
  `buh_archivo` int(11) DEFAULT NULL,
  `buh_fecha` date NOT NULL,
  `buh_bodega` varchar(30) NOT NULL,
  `buh_codigo` varchar(30) NOT NULL,
  `buh_codigo_funcional` varchar(30) DEFAULT NULL,
  `buh_codigo_vinculado` varchar(40) DEFAULT NULL,
  `buh_codigo_generico` varchar(30) DEFAULT NULL,
  `buh_estatus` varchar(4) DEFAULT NULL,
  `buh_clasificacion` varchar(4) DEFAULT NULL,
  `buh_responsable` varchar(15) DEFAULT NULL,
  `buh_ctv` decimal(7,2) DEFAULT NULL,
  `buh_pv` decimal(7,2) DEFAULT NULL,
  `buh_precio_promocion` decimal(7,2) DEFAULT NULL,
  `buh_promocion_desde` date DEFAULT NULL,
  `buh_promocion_hasta` date DEFAULT NULL,
  `buh_proveedor` int(11) DEFAULT NULL,
  `buh_perfil` int(11) DEFAULT NULL,
  `buh_horizonte` decimal(6,2) DEFAULT NULL,
  `buh_tiempo_suministro` decimal(10,2) DEFAULT NULL,
  `buh_frecuencia_reposicion` decimal(10,2) DEFAULT NULL,
  `buh_gdb` tinyint(2) DEFAULT NULL,
  `buh_cam` varchar(3) DEFAULT NULL,
  `buh_etapa` varchar(15) DEFAULT NULL,
  `buh_nuevo_buffer_sugerido` decimal(10,2) DEFAULT NULL,
  `buh_comportamiento` varchar(15) DEFAULT NULL,
  `buh_consumo` decimal(10,2) DEFAULT NULL,
  `buh_buffer_calculado` decimal(10,2) DEFAULT NULL,
  `buh_cobertura_buffer` decimal(10,2) DEFAULT NULL,
  `buh_cobertura_inventario_proyectado` decimal(10,2) DEFAULT NULL,
  `buh_cobertura_pedido_minimo` decimal(10,2) DEFAULT NULL,
  `buh_dias_desabastecimiento` int(11) DEFAULT NULL,
  `buh_ventas_perdidas` decimal(10,2) DEFAULT NULL,
  `buh_observaciones` varchar(60) DEFAULT NULL,
  `buh_nuevo_buffer_real` decimal(10,2) DEFAULT NULL,
  `buh_posponer_alerta_buf` date DEFAULT NULL,
  `buh_posponer_alerta_red` date DEFAULT NULL,
  `buh_posponer_alerta_gdb` date DEFAULT NULL,
  `buh_buffer_minimo` decimal(8,2) DEFAULT NULL,
  `buh_buffer_maximo` decimal(8,2) DEFAULT NULL,
  `buh_pedido_minimo` decimal(8,2) DEFAULT NULL,
  `buh_redondeo_pedido_minimo` varchar(25) DEFAULT NULL,
  `buh_pedido_minimo_grupo` decimal(8,2) DEFAULT NULL,
  `buh_unidad_empaque` decimal(8,2) DEFAULT NULL,
  `buh_redondeo_unidad_empaque` char(1) DEFAULT NULL,
  `buh_porcentaje_atencion` decimal(8,2) DEFAULT NULL,
  `buh_impacto_faltante` decimal(8,2) DEFAULT NULL,
  `buh_buffer_actual` decimal(8,2) DEFAULT NULL,
  `buh_zona_amarilla` decimal(8,2) DEFAULT NULL,
  `buh_zona_roja` decimal(8,2) DEFAULT NULL,
  `buh_color_inventario_fisico` char(1) DEFAULT NULL,
  `buh_color_inventario_proyectado` char(1) DEFAULT NULL,
  `buh_ultimo_buffer` decimal(8,2) DEFAULT NULL,
  `buh_buffer_anterior_estacion` decimal(8,2) DEFAULT NULL,
  `buh_buffer_estacional` decimal(8,2) DEFAULT NULL,
  `buh_inventario_proveedor` decimal(13,2) DEFAULT NULL,
  `buh_inventario_fisico` decimal(10,2) DEFAULT NULL,
  `buh_estado_inventario_fisico` decimal(8,2) DEFAULT NULL,
  `buh_transito` decimal(10,2) DEFAULT NULL,
  `buh_negociacion` decimal(10,2) DEFAULT NULL,
  `buh_produccion` decimal(10,2) DEFAULT NULL,
  `buh_embarcado` decimal(10,2) DEFAULT NULL,
  `buh_comprometido` decimal(10,2) DEFAULT NULL,
  `buh_backorder` decimal(10,2) DEFAULT NULL,
  `buh_inventario_proyectado` decimal(8,2) DEFAULT NULL,
  `buh_estado_inventario_proyectado` decimal(6,2) DEFAULT NULL,
  `buh_ingresos` decimal(8,2) DEFAULT NULL,
  `buh_egresos` decimal(8,2) DEFAULT NULL,
  `buh_pedido_calculado_auxiliar` decimal(8,2) DEFAULT NULL,
  `buh_pedido_calculado` decimal(8,2) DEFAULT NULL,
  `buh_pedido_promedio` decimal(8,2) DEFAULT NULL,
  `buh_pedido_real` decimal(8,2) DEFAULT NULL,
  `buh_calendario_estacional` varchar(150) DEFAULT NULL,
  `buh_accion_estacional` varchar(150) DEFAULT NULL,
  `buh_etapa_estacional` varchar(100) DEFAULT NULL,
  `buh_tdd` decimal(12,2) DEFAULT NULL,
  `buh_idd` decimal(12,2) DEFAULT NULL,
  `buh_roi_pasado` decimal(8,2) DEFAULT NULL,
  `buh_roi_proyectado` decimal(8,2) DEFAULT NULL,
  `buh_velocity` decimal(8,2) DEFAULT NULL,
  `buh_nivel_servicio` decimal(8,2) DEFAULT NULL,
  `buh_ultimo_cambio` date DEFAULT NULL,
  `buh_nuevo_inicio_horizonte` date DEFAULT NULL,
  `buh_inicio_horizonte` date DEFAULT NULL,
  `buh_fin_horizonte` date DEFAULT NULL,
  `buh_ultima_transferencia_ini` date DEFAULT NULL,
  `buh_ultima_transferencia_fin` date DEFAULT NULL,
  `buh_variabilidad` decimal(6,2) DEFAULT NULL,
  `buh_rojo_acumulado` decimal(10,2) DEFAULT NULL,
  `buh_negro` decimal(3,2) DEFAULT NULL,
  `buh_rojo` decimal(3,2) DEFAULT NULL,
  `buh_amarillo` decimal(3,2) DEFAULT NULL,
  `buh_verde` decimal(3,2) DEFAULT NULL,
  `buh_lila` decimal(3,2) DEFAULT NULL,
  `buh_estado_reposiciones` varchar(25) DEFAULT NULL,
  `buh_fecha_nuevo_pedido` date DEFAULT NULL,
  `buh_fecha_esperada_arribo` date DEFAULT NULL,
  PRIMARY KEY (`buh_fecha`,`buh_empresa`,`buh_bodega`,`buh_codigo`),
  KEY `IN_Normal` (`buh_fecha`,`buh_bodega`,`buh_codigo`) USING BTREE,
  KEY `IN_Grafico_Individual` (`buh_bodega`,`buh_codigo`,`buh_fecha`) USING BTREE,
  KEY `IN_Grafico_Completo` (`buh_bodega`,`buh_fecha`) USING BTREE,
  KEY `IN_Grafico_Individual2` (`buh_codigo`,`buh_bodega`,`buh_fecha`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for buffer_hist_cortado
-- ----------------------------
DROP TABLE IF EXISTS `buffer_hist_cortado`;
CREATE TABLE `buffer_hist_cortado` (
  `buffer_hist_id` int(11) NOT NULL,
  `buh_empresa` varchar(15) NOT NULL COMMENT 'C',
  `buh_archivo` int(11) DEFAULT NULL,
  `buh_fecha` date NOT NULL,
  `buh_bodega` varchar(30) NOT NULL,
  `buh_codigo` varchar(30) NOT NULL,
  `buh_codigo_funcional` varchar(30) DEFAULT NULL,
  `buh_codigo_vinculado` varchar(40) DEFAULT NULL,
  `buh_codigo_generico` varchar(30) DEFAULT NULL,
  `buh_estatus` varchar(4) DEFAULT NULL,
  `buh_clasificacion` varchar(4) DEFAULT NULL,
  `buh_responsable` varchar(15) DEFAULT NULL,
  `buh_ctv` decimal(7,2) DEFAULT NULL,
  `buh_pv` decimal(7,2) DEFAULT NULL,
  `buh_precio_promocion` decimal(7,2) DEFAULT NULL,
  `buh_promocion_desde` date DEFAULT NULL,
  `buh_promocion_hasta` date DEFAULT NULL,
  `buh_proveedor` int(11) DEFAULT NULL,
  `buh_perfil` int(11) DEFAULT NULL,
  `buh_horizonte` decimal(6,2) DEFAULT NULL,
  `buh_tiempo_suministro` decimal(10,2) DEFAULT NULL,
  `buh_frecuencia_reposicion` decimal(10,2) DEFAULT NULL,
  `buh_gdb` tinyint(2) DEFAULT NULL,
  `buh_cam` varchar(3) DEFAULT NULL,
  `buh_etapa` varchar(15) DEFAULT NULL,
  `buh_nuevo_buffer_sugerido` decimal(10,2) DEFAULT NULL,
  `buh_comportamiento` varchar(15) DEFAULT NULL,
  `buh_consumo` decimal(10,2) DEFAULT NULL,
  `buh_buffer_calculado` decimal(10,2) DEFAULT NULL,
  `buh_cobertura_buffer` decimal(10,2) DEFAULT NULL,
  `buh_cobertura_inventario_proyectado` decimal(10,2) DEFAULT NULL,
  `buh_cobertura_pedido_minimo` decimal(10,2) DEFAULT NULL,
  `buh_dias_desabastecimiento` int(11) DEFAULT NULL,
  `buh_ventas_perdidas` decimal(10,2) DEFAULT NULL,
  `buh_observaciones` varchar(60) DEFAULT NULL,
  `buh_nuevo_buffer_real` decimal(10,2) DEFAULT NULL,
  `buh_posponer_alerta_buf` date DEFAULT NULL,
  `buh_posponer_alerta_red` date DEFAULT NULL,
  `buh_posponer_alerta_gdb` date DEFAULT NULL,
  `buh_buffer_minimo` decimal(8,2) DEFAULT NULL,
  `buh_buffer_maximo` decimal(8,2) DEFAULT NULL,
  `buh_pedido_minimo` decimal(8,2) DEFAULT NULL,
  `buh_redondeo_pedido_minimo` varchar(25) DEFAULT NULL,
  `buh_pedido_minimo_grupo` decimal(8,2) DEFAULT NULL,
  `buh_unidad_empaque` decimal(8,2) DEFAULT NULL,
  `buh_redondeo_unidad_empaque` char(1) DEFAULT NULL,
  `buh_porcentaje_atencion` decimal(8,2) DEFAULT NULL,
  `buh_impacto_faltante` decimal(8,2) DEFAULT NULL,
  `buh_buffer_actual` decimal(8,2) DEFAULT NULL,
  `buh_zona_amarilla` decimal(8,2) DEFAULT NULL,
  `buh_zona_roja` decimal(8,2) DEFAULT NULL,
  `buh_color_inventario_fisico` char(1) DEFAULT NULL,
  `buh_color_inventario_proyectado` char(1) DEFAULT NULL,
  `buh_ultimo_buffer` decimal(8,2) DEFAULT NULL,
  `buh_buffer_anterior_estacion` decimal(8,2) DEFAULT NULL,
  `buh_buffer_estacional` decimal(8,2) DEFAULT NULL,
  `buh_inventario_proveedor` decimal(13,2) DEFAULT NULL,
  `buh_inventario_fisico` decimal(10,2) DEFAULT NULL,
  `buh_estado_inventario_fisico` decimal(8,2) DEFAULT NULL,
  `buh_transito` decimal(10,2) DEFAULT NULL,
  `buh_negociacion` decimal(10,2) DEFAULT NULL,
  `buh_produccion` decimal(10,2) DEFAULT NULL,
  `buh_embarcado` decimal(10,2) DEFAULT NULL,
  `buh_comprometido` decimal(10,2) DEFAULT NULL,
  `buh_backorder` decimal(10,2) DEFAULT NULL,
  `buh_inventario_proyectado` decimal(8,2) DEFAULT NULL,
  `buh_estado_inventario_proyectado` decimal(6,2) DEFAULT NULL,
  `buh_ingresos` decimal(8,2) DEFAULT NULL,
  `buh_egresos` decimal(8,2) DEFAULT NULL,
  `buh_pedido_calculado_auxiliar` decimal(8,2) DEFAULT NULL,
  `buh_pedido_calculado` decimal(8,2) DEFAULT NULL,
  `buh_pedido_promedio` decimal(8,2) DEFAULT NULL,
  `buh_pedido_real` decimal(8,2) DEFAULT NULL,
  `buh_calendario_estacional` varchar(150) DEFAULT NULL,
  `buh_accion_estacional` varchar(150) DEFAULT NULL,
  `buh_etapa_estacional` varchar(100) DEFAULT NULL,
  `buh_tdd` decimal(12,2) DEFAULT NULL,
  `buh_idd` decimal(12,2) DEFAULT NULL,
  `buh_roi_pasado` decimal(8,2) DEFAULT NULL,
  `buh_roi_proyectado` decimal(8,2) DEFAULT NULL,
  `buh_velocity` decimal(8,2) DEFAULT NULL,
  `buh_nivel_servicio` decimal(8,2) DEFAULT NULL,
  `buh_ultimo_cambio` date DEFAULT NULL,
  `buh_nuevo_inicio_horizonte` date DEFAULT NULL,
  `buh_inicio_horizonte` date DEFAULT NULL,
  `buh_fin_horizonte` date DEFAULT NULL,
  `buh_ultima_transferencia_ini` date DEFAULT NULL,
  `buh_ultima_transferencia_fin` date DEFAULT NULL,
  `buh_variabilidad` decimal(6,2) DEFAULT NULL,
  `buh_rojo_acumulado` decimal(10,2) DEFAULT NULL,
  `buh_negro` decimal(3,2) DEFAULT NULL,
  `buh_rojo` decimal(3,2) DEFAULT NULL,
  `buh_amarillo` decimal(3,2) DEFAULT NULL,
  `buh_verde` decimal(3,2) DEFAULT NULL,
  `buh_lila` decimal(3,2) DEFAULT NULL,
  `buh_estado_reposiciones` varchar(25) DEFAULT NULL,
  `buh_fecha_nuevo_pedido` date DEFAULT NULL,
  `buh_fecha_esperada_arribo` date DEFAULT NULL,
  PRIMARY KEY (`buh_fecha`,`buh_empresa`,`buh_bodega`,`buh_codigo`),
  KEY `IN_Normal` (`buh_fecha`,`buh_bodega`,`buh_codigo`) USING BTREE,
  KEY `IN_Grafico_Individual` (`buh_bodega`,`buh_codigo`,`buh_fecha`) USING BTREE,
  KEY `IN_Grafico_Completo` (`buh_bodega`,`buh_fecha`) USING BTREE,
  KEY `IN_Grafico_Individual2` (`buh_codigo`,`buh_bodega`,`buh_fecha`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for buffer_hist_oracle
-- ----------------------------
DROP TABLE IF EXISTS `buffer_hist_oracle`;
CREATE TABLE `buffer_hist_oracle` (
  `buffer_hist_id` int(11) NOT NULL,
  `buh_empresa` varchar(15) NOT NULL COMMENT 'C',
  `buh_archivo` int(11) DEFAULT NULL,
  `buh_fecha` date NOT NULL,
  `buh_bodega` varchar(30) NOT NULL,
  `buh_codigo` varchar(30) NOT NULL,
  `buh_codigo_funcional` varchar(30) DEFAULT NULL,
  `buh_codigo_vinculado` varchar(30) DEFAULT NULL,
  `buh_codigo_generico` varchar(30) DEFAULT NULL,
  `buh_estatus` varchar(4) DEFAULT NULL,
  `buh_clasificacion` varchar(4) DEFAULT NULL,
  `buh_responsable` varchar(15) DEFAULT NULL,
  `buh_ctv` decimal(7,2) DEFAULT NULL,
  `buh_pv` decimal(7,2) DEFAULT NULL,
  `buh_precio_promocion` decimal(7,2) DEFAULT NULL,
  `buh_promocion_desde` date DEFAULT NULL,
  `buh_promocion_hasta` date DEFAULT NULL,
  `buh_proveedor` int(11) DEFAULT NULL,
  `buh_perfil` int(11) DEFAULT NULL,
  `buh_horizonte` decimal(6,2) DEFAULT NULL,
  `buh_tiempo_suministro` decimal(10,2) DEFAULT NULL,
  `buh_frecuencia_reposicion` decimal(10,2) DEFAULT NULL,
  `buh_gdb` tinyint(2) DEFAULT NULL,
  `buh_cam` varchar(3) DEFAULT NULL,
  `buh_etapa` varchar(15) DEFAULT NULL,
  `buh_nuevo_buffer_sugerido` decimal(10,2) DEFAULT NULL,
  `buh_comportamiento` varchar(15) DEFAULT NULL,
  `buh_consumo` decimal(10,2) DEFAULT NULL,
  `buh_buffer_calculado` decimal(10,2) DEFAULT NULL,
  `buh_cobertura_buffer` decimal(10,2) DEFAULT NULL,
  `buh_cobertura_inv_proy` decimal(10,2) DEFAULT NULL,
  `buh_cobertura_ped_min` decimal(10,2) DEFAULT NULL,
  `buh_dias_desabast` int(11) DEFAULT NULL,
  `buh_ventas_perdidas` decimal(10,2) DEFAULT NULL,
  `buh_observaciones` varchar(60) DEFAULT NULL,
  `buh_nuevo_buffer_real` decimal(10,2) DEFAULT NULL,
  `buh_posponer_alerta_buf` date DEFAULT NULL,
  `buh_posponer_alerta_red` date DEFAULT NULL,
  `buh_posponer_alerta_gdb` date DEFAULT NULL,
  `buh_buffer_minimo` decimal(8,2) DEFAULT NULL,
  `buh_buffer_maximo` decimal(8,2) DEFAULT NULL,
  `buh_pedido_minimo` decimal(8,2) DEFAULT NULL,
  `buh_redondeo_ped_min` varchar(25) DEFAULT NULL,
  `buh_pedido_minimo_grupo` decimal(8,2) DEFAULT NULL,
  `buh_unidad_empaque` decimal(8,2) DEFAULT NULL,
  `buh_redondeo_u_emp` char(1) DEFAULT NULL,
  `buh_porcentaje_atencion` decimal(8,2) DEFAULT NULL,
  `buh_impacto_faltante` decimal(8,2) DEFAULT NULL,
  `buh_buffer_actual` decimal(8,2) DEFAULT NULL,
  `buh_zona_amarilla` decimal(8,2) DEFAULT NULL,
  `buh_zona_roja` decimal(8,2) DEFAULT NULL,
  `buh_color_inv_fisico` char(1) DEFAULT NULL,
  `buh_color_inv_proyectado` char(1) DEFAULT NULL,
  `buh_ultimo_buffer` decimal(8,2) DEFAULT NULL,
  `buh_buffer_anterior_estacion` decimal(8,2) DEFAULT NULL,
  `buh_buffer_estacional` decimal(8,2) DEFAULT NULL,
  `buh_inventario_proveedor` decimal(13,2) DEFAULT NULL,
  `buh_inventario_fisico` decimal(10,2) DEFAULT NULL,
  `buh_estado_inventario_fisico` decimal(8,2) DEFAULT NULL,
  `buh_transito` decimal(10,2) DEFAULT NULL,
  `buh_negociacion` decimal(10,2) DEFAULT NULL,
  `buh_produccion` decimal(10,2) DEFAULT NULL,
  `buh_embarcado` decimal(10,2) DEFAULT NULL,
  `buh_comprometido` decimal(10,2) DEFAULT NULL,
  `buh_backorder` decimal(10,2) DEFAULT NULL,
  `buh_inventario_proyectado` decimal(8,2) DEFAULT NULL,
  `buh_estado_inv_proy` decimal(6,2) DEFAULT NULL,
  `buh_ingresos` decimal(8,2) DEFAULT NULL,
  `buh_egresos` decimal(8,2) DEFAULT NULL,
  `buh_pedido_calc_aux` decimal(8,2) DEFAULT NULL,
  `buh_pedido_calculado` decimal(8,2) DEFAULT NULL,
  `buh_pedido_promedio` decimal(8,2) DEFAULT NULL,
  `buh_pedido_real` decimal(8,2) DEFAULT NULL,
  `buh_calendario_estacional` varchar(150) DEFAULT NULL,
  `buh_accion_estacional` varchar(150) DEFAULT NULL,
  `buh_etapa_estacional` varchar(100) DEFAULT NULL,
  `buh_tdd` decimal(12,2) DEFAULT NULL,
  `buh_idd` decimal(12,2) DEFAULT NULL,
  `buh_roi_pasado` decimal(8,2) DEFAULT NULL,
  `buh_roi_proyectado` decimal(8,2) DEFAULT NULL,
  `buh_velocity` decimal(8,2) DEFAULT NULL,
  `buh_nivel_servicio` decimal(8,2) DEFAULT NULL,
  `buh_ultimo_cambio` date DEFAULT NULL,
  `buh_nuevo_inicio_horizonte` date DEFAULT NULL,
  `buh_inicio_horizonte` date DEFAULT NULL,
  `buh_fin_horizonte` date DEFAULT NULL,
  `buh_ultima_transferencia_ini` date DEFAULT NULL,
  `buh_ultima_transferencia_fin` date DEFAULT NULL,
  `buh_variabilidad` decimal(6,2) DEFAULT NULL,
  `buh_rojo_acumulado` decimal(10,2) DEFAULT NULL,
  `buh_negro` decimal(3,2) DEFAULT NULL,
  `buh_rojo` decimal(3,2) DEFAULT NULL,
  `buh_amarillo` decimal(3,2) DEFAULT NULL,
  `buh_verde` decimal(3,2) DEFAULT NULL,
  `buh_lila` decimal(3,2) DEFAULT NULL,
  PRIMARY KEY (`buh_fecha`,`buh_empresa`,`buh_bodega`,`buh_codigo`),
  KEY `IN_Normal` (`buh_fecha`,`buh_bodega`,`buh_codigo`) USING BTREE,
  KEY `IN_Grafico_Individual` (`buh_bodega`,`buh_codigo`,`buh_fecha`) USING BTREE,
  KEY `IN_Grafico_Completo` (`buh_bodega`,`buh_fecha`) USING BTREE,
  KEY `IN_Grafico_Individual2` (`buh_codigo`,`buh_bodega`,`buh_fecha`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for buffer_hoy
-- ----------------------------
DROP TABLE IF EXISTS `buffer_hoy`;
CREATE TABLE `buffer_hoy` (
  `buffer_hist_id` int(11) NOT NULL,
  `buh_empresa` varchar(15) NOT NULL COMMENT 'C',
  `buh_archivo` int(11) DEFAULT NULL,
  `buh_fecha` date NOT NULL,
  `buh_bodega` varchar(30) NOT NULL,
  `buh_codigo` varchar(30) NOT NULL,
  `buh_codigo_funcional` varchar(30) DEFAULT NULL,
  `buh_codigo_vinculado` varchar(40) DEFAULT NULL,
  `buh_codigo_generico` varchar(30) DEFAULT NULL,
  `buh_estatus` varchar(4) DEFAULT NULL,
  `buh_clasificacion` varchar(4) DEFAULT NULL,
  `buh_responsable` varchar(15) DEFAULT NULL,
  `buh_ctv` decimal(7,2) DEFAULT NULL,
  `buh_pv` decimal(7,2) DEFAULT NULL,
  `buh_precio_promocion` decimal(7,2) DEFAULT NULL,
  `buh_promocion_desde` date DEFAULT NULL,
  `buh_promocion_hasta` date DEFAULT NULL,
  `buh_proveedor` int(11) DEFAULT NULL,
  `buh_perfil` int(11) DEFAULT NULL,
  `buh_horizonte` decimal(6,2) DEFAULT NULL,
  `buh_tiempo_suministro` decimal(10,2) DEFAULT NULL,
  `buh_frecuencia_reposicion` decimal(10,2) DEFAULT NULL,
  `buh_gdb` tinyint(2) DEFAULT NULL,
  `buh_cam` varchar(3) DEFAULT NULL,
  `buh_etapa` varchar(15) DEFAULT NULL,
  `buh_nuevo_buffer_sugerido` decimal(10,2) DEFAULT NULL,
  `buh_comportamiento` varchar(15) DEFAULT NULL,
  `buh_consumo` decimal(10,2) DEFAULT NULL,
  `buh_buffer_calculado` decimal(10,2) DEFAULT NULL,
  `buh_cobertura_buffer` decimal(10,2) DEFAULT NULL,
  `buh_cobertura_inventario_proyectado` decimal(10,2) DEFAULT NULL,
  `buh_cobertura_pedido_minimo` decimal(10,2) DEFAULT NULL,
  `buh_dias_desabastecimiento` int(11) DEFAULT NULL,
  `buh_ventas_perdidas` decimal(10,2) DEFAULT NULL,
  `buh_observaciones` varchar(60) DEFAULT NULL,
  `buh_nuevo_buffer_real` decimal(10,2) DEFAULT NULL,
  `buh_posponer_alerta_buf` date DEFAULT NULL,
  `buh_posponer_alerta_red` date DEFAULT NULL,
  `buh_posponer_alerta_gdb` date DEFAULT NULL,
  `buh_buffer_minimo` decimal(8,2) DEFAULT NULL,
  `buh_buffer_maximo` decimal(8,2) DEFAULT NULL,
  `buh_pedido_minimo` decimal(8,2) DEFAULT NULL,
  `buh_redondeo_pedido_minimo` varchar(25) DEFAULT NULL,
  `buh_pedido_minimo_grupo` decimal(8,2) DEFAULT NULL,
  `buh_unidad_empaque` decimal(8,2) DEFAULT NULL,
  `buh_redondeo_unidad_empaque` char(1) DEFAULT NULL,
  `buh_porcentaje_atencion` decimal(8,2) DEFAULT NULL,
  `buh_impacto_faltante` decimal(8,2) DEFAULT NULL,
  `buh_buffer_actual` decimal(8,2) DEFAULT NULL,
  `buh_zona_amarilla` decimal(8,2) DEFAULT NULL,
  `buh_zona_roja` decimal(8,2) DEFAULT NULL,
  `buh_color_inventario_fisico` char(1) DEFAULT NULL,
  `buh_color_inventario_proyectado` char(1) DEFAULT NULL,
  `buh_ultimo_buffer` decimal(8,2) DEFAULT NULL,
  `buh_buffer_anterior_estacion` decimal(8,2) DEFAULT NULL,
  `buh_buffer_estacional` decimal(8,2) DEFAULT NULL,
  `buh_inventario_proveedor` decimal(13,2) DEFAULT NULL,
  `buh_inventario_fisico` decimal(10,2) DEFAULT NULL,
  `buh_estado_inventario_fisico` decimal(8,2) DEFAULT NULL,
  `buh_transito` decimal(10,2) DEFAULT NULL,
  `buh_negociacion` decimal(10,2) DEFAULT NULL,
  `buh_produccion` decimal(10,2) DEFAULT NULL,
  `buh_embarcado` decimal(10,2) DEFAULT NULL,
  `buh_comprometido` decimal(10,2) DEFAULT NULL,
  `buh_backorder` decimal(10,2) DEFAULT NULL,
  `buh_inventario_proyectado` decimal(8,2) DEFAULT NULL,
  `buh_estado_inventario_proyectado` decimal(6,2) DEFAULT NULL,
  `buh_ingresos` decimal(8,2) DEFAULT NULL,
  `buh_egresos` decimal(8,2) DEFAULT NULL,
  `buh_pedido_calculado_auxiliar` decimal(8,2) DEFAULT NULL,
  `buh_pedido_calculado` decimal(8,2) DEFAULT NULL,
  `buh_pedido_promedio` decimal(8,2) DEFAULT NULL,
  `buh_pedido_real` decimal(8,2) DEFAULT NULL,
  `buh_calendario_estacional` varchar(150) DEFAULT NULL,
  `buh_accion_estacional` varchar(150) DEFAULT NULL,
  `buh_etapa_estacional` varchar(100) DEFAULT NULL,
  `buh_tdd` decimal(12,2) DEFAULT NULL,
  `buh_idd` decimal(12,2) DEFAULT NULL,
  `buh_roi_pasado` decimal(8,2) DEFAULT NULL,
  `buh_roi_proyectado` decimal(8,2) DEFAULT NULL,
  `buh_velocity` decimal(8,2) DEFAULT NULL,
  `buh_nivel_servicio` decimal(8,2) DEFAULT NULL,
  `buh_ultimo_cambio` date DEFAULT NULL,
  `buh_nuevo_inicio_horizonte` date DEFAULT NULL,
  `buh_inicio_horizonte` date DEFAULT NULL,
  `buh_fin_horizonte` date DEFAULT NULL,
  `buh_ultima_transferencia_ini` date DEFAULT NULL,
  `buh_ultima_transferencia_fin` date DEFAULT NULL,
  `buh_variabilidad` decimal(6,2) DEFAULT NULL,
  `buh_rojo_acumulado` decimal(10,2) DEFAULT NULL,
  `buh_negro` decimal(3,2) DEFAULT NULL,
  `buh_rojo` decimal(3,2) DEFAULT NULL,
  `buh_amarillo` decimal(3,2) DEFAULT NULL,
  `buh_verde` decimal(3,2) DEFAULT NULL,
  `buh_lila` decimal(3,2) DEFAULT NULL,
  `buh_estado_reposiciones` varchar(25) DEFAULT NULL,
  `buh_fecha_nuevo_pedido` date DEFAULT NULL,
  `buh_fecha_esperada_arribo` date DEFAULT NULL,
  PRIMARY KEY (`buh_fecha`,`buh_empresa`,`buh_bodega`,`buh_codigo`),
  KEY `IN_Normal` (`buh_fecha`,`buh_bodega`,`buh_codigo`) USING BTREE,
  KEY `IN_Grafico_Individual` (`buh_bodega`,`buh_codigo`,`buh_fecha`) USING BTREE,
  KEY `IN_Grafico_Completo` (`buh_bodega`,`buh_fecha`) USING BTREE,
  KEY `IN_Grafico_Individual2` (`buh_codigo`,`buh_bodega`,`buh_fecha`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for buffer_hoy_temp
-- ----------------------------
DROP TABLE IF EXISTS `buffer_hoy_temp`;
CREATE TABLE `buffer_hoy_temp` (
  `buffer_hist_id` int(11) NOT NULL,
  `buh_empresa` varchar(15) NOT NULL COMMENT 'C',
  `buh_archivo` int(11) DEFAULT NULL,
  `buh_fecha` date NOT NULL,
  `buh_bodega` varchar(30) NOT NULL,
  `buh_codigo` varchar(30) NOT NULL,
  `buh_codigo_funcional` varchar(30) DEFAULT NULL,
  `buh_codigo_vinculado` varchar(40) DEFAULT NULL,
  `buh_codigo_generico` varchar(30) DEFAULT NULL,
  `buh_estatus` varchar(4) DEFAULT NULL,
  `buh_clasificacion` varchar(4) DEFAULT NULL,
  `buh_responsable` varchar(15) DEFAULT NULL,
  `buh_ctv` decimal(7,2) DEFAULT NULL,
  `buh_pv` decimal(7,2) DEFAULT NULL,
  `buh_precio_promocion` decimal(7,2) DEFAULT NULL,
  `buh_promocion_desde` date DEFAULT NULL,
  `buh_promocion_hasta` date DEFAULT NULL,
  `buh_proveedor` int(11) DEFAULT NULL,
  `buh_perfil` int(11) DEFAULT NULL,
  `buh_horizonte` decimal(6,2) DEFAULT NULL,
  `buh_tiempo_suministro` decimal(10,2) DEFAULT NULL,
  `buh_frecuencia_reposicion` decimal(10,2) DEFAULT NULL,
  `buh_gdb` tinyint(2) DEFAULT NULL,
  `buh_cam` varchar(3) DEFAULT NULL,
  `buh_etapa` varchar(15) DEFAULT NULL,
  `buh_nuevo_buffer_sugerido` decimal(10,2) DEFAULT NULL,
  `buh_comportamiento` varchar(15) DEFAULT NULL,
  `buh_consumo` decimal(10,2) DEFAULT NULL,
  `buh_buffer_calculado` decimal(10,2) DEFAULT NULL,
  `buh_cobertura_buffer` decimal(10,2) DEFAULT NULL,
  `buh_cobertura_inventario_proyectado` decimal(10,2) DEFAULT NULL,
  `buh_cobertura_pedido_minimo` decimal(10,2) DEFAULT NULL,
  `buh_dias_desabastecimiento` int(11) DEFAULT NULL,
  `buh_ventas_perdidas` decimal(10,2) DEFAULT NULL,
  `buh_observaciones` varchar(60) DEFAULT NULL,
  `buh_nuevo_buffer_real` decimal(10,2) DEFAULT NULL,
  `buh_posponer_alerta_buf` date DEFAULT NULL,
  `buh_posponer_alerta_red` date DEFAULT NULL,
  `buh_posponer_alerta_gdb` date DEFAULT NULL,
  `buh_buffer_minimo` decimal(8,2) DEFAULT NULL,
  `buh_buffer_maximo` decimal(8,2) DEFAULT NULL,
  `buh_pedido_minimo` decimal(8,2) DEFAULT NULL,
  `buh_redondeo_pedido_minimo` varchar(25) DEFAULT NULL,
  `buh_pedido_minimo_grupo` decimal(8,2) DEFAULT NULL,
  `buh_unidad_empaque` decimal(8,2) DEFAULT NULL,
  `buh_redondeo_unidad_empaque` char(1) DEFAULT NULL,
  `buh_porcentaje_atencion` decimal(8,2) DEFAULT NULL,
  `buh_impacto_faltante` decimal(8,2) DEFAULT NULL,
  `buh_buffer_actual` decimal(8,2) DEFAULT NULL,
  `buh_zona_amarilla` decimal(8,2) DEFAULT NULL,
  `buh_zona_roja` decimal(8,2) DEFAULT NULL,
  `buh_color_inventario_fisico` char(1) DEFAULT NULL,
  `buh_color_inventario_proyectado` char(1) DEFAULT NULL,
  `buh_ultimo_buffer` decimal(8,2) DEFAULT NULL,
  `buh_buffer_anterior_estacion` decimal(8,2) DEFAULT NULL,
  `buh_buffer_estacional` decimal(8,2) DEFAULT NULL,
  `buh_inventario_proveedor` decimal(13,2) DEFAULT NULL,
  `buh_inventario_fisico` decimal(10,2) DEFAULT NULL,
  `buh_estado_inventario_fisico` decimal(8,2) DEFAULT NULL,
  `buh_transito` decimal(10,2) DEFAULT NULL,
  `buh_negociacion` decimal(10,2) DEFAULT NULL,
  `buh_produccion` decimal(10,2) DEFAULT NULL,
  `buh_embarcado` decimal(10,2) DEFAULT NULL,
  `buh_comprometido` decimal(10,2) DEFAULT NULL,
  `buh_backorder` decimal(10,2) DEFAULT NULL,
  `buh_inventario_proyectado` decimal(8,2) DEFAULT NULL,
  `buh_estado_inventario_proyectado` decimal(6,2) DEFAULT NULL,
  `buh_ingresos` decimal(8,2) DEFAULT NULL,
  `buh_egresos` decimal(8,2) DEFAULT NULL,
  `buh_pedido_calculado_auxiliar` decimal(8,2) DEFAULT NULL,
  `buh_pedido_calculado` decimal(8,2) DEFAULT NULL,
  `buh_pedido_promedio` decimal(8,2) DEFAULT NULL,
  `buh_pedido_real` decimal(8,2) DEFAULT NULL,
  `buh_calendario_estacional` varchar(150) DEFAULT NULL,
  `buh_accion_estacional` varchar(150) DEFAULT NULL,
  `buh_etapa_estacional` varchar(100) DEFAULT NULL,
  `buh_tdd` decimal(12,2) DEFAULT NULL,
  `buh_idd` decimal(12,2) DEFAULT NULL,
  `buh_roi_pasado` decimal(8,2) DEFAULT NULL,
  `buh_roi_proyectado` decimal(8,2) DEFAULT NULL,
  `buh_velocity` decimal(8,2) DEFAULT NULL,
  `buh_nivel_servicio` decimal(8,2) DEFAULT NULL,
  `buh_ultimo_cambio` date DEFAULT NULL,
  `buh_nuevo_inicio_horizonte` date DEFAULT NULL,
  `buh_inicio_horizonte` date DEFAULT NULL,
  `buh_fin_horizonte` date DEFAULT NULL,
  `buh_ultima_transferencia_ini` date DEFAULT NULL,
  `buh_ultima_transferencia_fin` date DEFAULT NULL,
  `buh_variabilidad` decimal(6,2) DEFAULT NULL,
  `buh_rojo_acumulado` decimal(10,2) DEFAULT NULL,
  `buh_negro` decimal(3,2) DEFAULT NULL,
  `buh_rojo` decimal(3,2) DEFAULT NULL,
  `buh_amarillo` decimal(3,2) DEFAULT NULL,
  `buh_verde` decimal(3,2) DEFAULT NULL,
  `buh_lila` decimal(3,2) DEFAULT NULL,
  `buh_estado_reposiciones` varchar(25) DEFAULT NULL,
  `buh_fecha_nuevo_pedido` date DEFAULT NULL,
  `buh_fecha_esperada_arribo` date DEFAULT NULL,
  PRIMARY KEY (`buh_fecha`,`buh_empresa`,`buh_bodega`,`buh_codigo`),
  KEY `IN_Normal` (`buh_fecha`,`buh_bodega`,`buh_codigo`) USING BTREE,
  KEY `IN_Grafico_Individual` (`buh_bodega`,`buh_codigo`,`buh_fecha`) USING BTREE,
  KEY `IN_Grafico_Completo` (`buh_bodega`,`buh_fecha`) USING BTREE,
  KEY `IN_Grafico_Individual2` (`buh_codigo`,`buh_bodega`,`buh_fecha`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for buffer_hoy_temp_anterior
-- ----------------------------
DROP TABLE IF EXISTS `buffer_hoy_temp_anterior`;
CREATE TABLE `buffer_hoy_temp_anterior` (
  `buffer_hist_id` int(11) NOT NULL,
  `buh_empresa` varchar(15) NOT NULL COMMENT 'C',
  `buh_archivo` int(11) DEFAULT NULL,
  `buh_fecha` date NOT NULL,
  `buh_bodega` varchar(30) NOT NULL,
  `buh_codigo` varchar(30) NOT NULL,
  `buh_codigo_funcional` varchar(30) DEFAULT NULL,
  `buh_codigo_vinculado` varchar(30) DEFAULT NULL,
  `buh_codigo_generico` varchar(30) DEFAULT NULL,
  `buh_estatus` varchar(4) DEFAULT NULL,
  `buh_clasificacion` varchar(4) DEFAULT NULL,
  `buh_responsable` varchar(15) DEFAULT NULL,
  `buh_ctv` decimal(7,2) DEFAULT NULL,
  `buh_pv` decimal(7,2) DEFAULT NULL,
  `buh_precio_promocion` decimal(7,2) DEFAULT NULL,
  `buh_promocion_desde` date DEFAULT NULL,
  `buh_promocion_hasta` date DEFAULT NULL,
  `buh_proveedor` int(11) DEFAULT NULL,
  `buh_perfil` int(11) DEFAULT NULL,
  `buh_horizonte` decimal(6,2) DEFAULT NULL,
  `buh_tiempo_suministro` decimal(10,2) DEFAULT NULL,
  `buh_frecuencia_reposicion` decimal(10,2) DEFAULT NULL,
  `buh_gdb` tinyint(2) DEFAULT NULL,
  `buh_cam` varchar(3) DEFAULT NULL,
  `buh_etapa` varchar(15) DEFAULT NULL,
  `buh_nuevo_buffer_sugerido` decimal(10,2) DEFAULT NULL,
  `buh_comportamiento` varchar(15) DEFAULT NULL,
  `buh_consumo` decimal(10,2) DEFAULT NULL,
  `buh_buffer_calculado` decimal(10,2) DEFAULT NULL,
  `buh_cobertura_buffer` decimal(10,2) DEFAULT NULL,
  `buh_cobertura_inventario_proyectado` decimal(10,2) DEFAULT NULL,
  `buh_cobertura_pedido_minimo` decimal(10,2) DEFAULT NULL,
  `buh_dias_desabastecimiento` int(11) DEFAULT NULL,
  `buh_ventas_perdidas` decimal(10,2) DEFAULT NULL,
  `buh_observaciones` varchar(60) DEFAULT NULL,
  `buh_nuevo_buffer_real` decimal(10,2) DEFAULT NULL,
  `buh_posponer_alerta_buf` date DEFAULT NULL,
  `buh_posponer_alerta_red` date DEFAULT NULL,
  `buh_posponer_alerta_gdb` date DEFAULT NULL,
  `buh_buffer_minimo` decimal(8,2) DEFAULT NULL,
  `buh_buffer_maximo` decimal(8,2) DEFAULT NULL,
  `buh_pedido_minimo` decimal(8,2) DEFAULT NULL,
  `buh_redondeo_pedido_minimo` varchar(25) DEFAULT NULL,
  `buh_pedido_minimo_grupo` decimal(8,2) DEFAULT NULL,
  `buh_unidad_empaque` decimal(8,2) DEFAULT NULL,
  `buh_redondeo_unidad_empaque` char(1) DEFAULT NULL,
  `buh_porcentaje_atencion` decimal(8,2) DEFAULT NULL,
  `buh_impacto_faltante` decimal(8,2) DEFAULT NULL,
  `buh_buffer_actual` decimal(8,2) DEFAULT NULL,
  `buh_zona_amarilla` decimal(8,2) DEFAULT NULL,
  `buh_zona_roja` decimal(8,2) DEFAULT NULL,
  `buh_color_inventario_fisico` char(1) DEFAULT NULL,
  `buh_color_inventario_proyectado` char(1) DEFAULT NULL,
  `buh_ultimo_buffer` decimal(8,2) DEFAULT NULL,
  `buh_buffer_anterior_estacion` decimal(8,2) DEFAULT NULL,
  `buh_buffer_estacional` decimal(8,2) DEFAULT NULL,
  `buh_inventario_proveedor` decimal(13,2) DEFAULT NULL,
  `buh_inventario_fisico` decimal(10,2) DEFAULT NULL,
  `buh_estado_inventario_fisico` decimal(8,2) DEFAULT NULL,
  `buh_transito` decimal(10,2) DEFAULT NULL,
  `buh_negociacion` decimal(10,2) DEFAULT NULL,
  `buh_produccion` decimal(10,2) DEFAULT NULL,
  `buh_embarcado` decimal(10,2) DEFAULT NULL,
  `buh_comprometido` decimal(10,2) DEFAULT NULL,
  `buh_backorder` decimal(10,2) DEFAULT NULL,
  `buh_inventario_proyectado` decimal(8,2) DEFAULT NULL,
  `buh_estado_inventario_proyectado` decimal(6,2) DEFAULT NULL,
  `buh_ingresos` decimal(8,2) DEFAULT NULL,
  `buh_egresos` decimal(8,2) DEFAULT NULL,
  `buh_pedido_calculado_auxiliar` decimal(8,2) DEFAULT NULL,
  `buh_pedido_calculado` decimal(8,2) DEFAULT NULL,
  `buh_pedido_promedio` decimal(8,2) DEFAULT NULL,
  `buh_pedido_real` decimal(8,2) DEFAULT NULL,
  `buh_calendario_estacional` varchar(150) DEFAULT NULL,
  `buh_accion_estacional` varchar(150) DEFAULT NULL,
  `buh_etapa_estacional` varchar(100) DEFAULT NULL,
  `buh_tdd` decimal(12,2) DEFAULT NULL,
  `buh_idd` decimal(12,2) DEFAULT NULL,
  `buh_roi_pasado` decimal(8,2) DEFAULT NULL,
  `buh_roi_proyectado` decimal(8,2) DEFAULT NULL,
  `buh_velocity` decimal(8,2) DEFAULT NULL,
  `buh_nivel_servicio` decimal(8,2) DEFAULT NULL,
  `buh_ultimo_cambio` date DEFAULT NULL,
  `buh_nuevo_inicio_horizonte` date DEFAULT NULL,
  `buh_inicio_horizonte` date DEFAULT NULL,
  `buh_fin_horizonte` date DEFAULT NULL,
  `buh_ultima_transferencia_ini` date DEFAULT NULL,
  `buh_ultima_transferencia_fin` date DEFAULT NULL,
  `buh_variabilidad` decimal(6,2) DEFAULT NULL,
  `buh_rojo_acumulado` decimal(10,2) DEFAULT NULL,
  `buh_negro` decimal(3,2) DEFAULT NULL,
  `buh_rojo` decimal(3,2) DEFAULT NULL,
  `buh_amarillo` decimal(3,2) DEFAULT NULL,
  `buh_verde` decimal(3,2) DEFAULT NULL,
  `buh_lila` decimal(3,2) DEFAULT NULL,
  PRIMARY KEY (`buh_fecha`,`buh_empresa`,`buh_bodega`,`buh_codigo`),
  KEY `IN_Normal` (`buh_fecha`,`buh_bodega`,`buh_codigo`) USING BTREE,
  KEY `IN_Grafico_Individual` (`buh_bodega`,`buh_codigo`,`buh_fecha`) USING BTREE,
  KEY `IN_Grafico_Completo` (`buh_bodega`,`buh_fecha`) USING BTREE,
  KEY `IN_Grafico_Individual2` (`buh_codigo`,`buh_bodega`,`buh_fecha`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for buffer_periodo
-- ----------------------------
DROP TABLE IF EXISTS `buffer_periodo`;
CREATE TABLE `buffer_periodo` (
  `EMPRESA` varchar(30) DEFAULT NULL COMMENT 'Nombre simplificado de la empresa.',
  `BODEGA` varchar(60) DEFAULT NULL COMMENT 'Nombre descriptivo de la bodega',
  `HOJA CB` varchar(50) DEFAULT NULL,
  `CODIGO` varchar(30) NOT NULL,
  `CODIGO VINCULADO` varchar(30) DEFAULT NULL,
  `DESCRIPCION` varchar(255) DEFAULT NULL COMMENT 'Nombre completo del producto',
  `GRUPO` varchar(80) DEFAULT NULL COMMENT 'Descripción del grupo al cual pertenece el ítem',
  `LINEA` varchar(80) DEFAULT NULL COMMENT 'Descripción de la línea a la cual pertenece el ítem',
  `SUBLINEA` varchar(80) DEFAULT NULL COMMENT 'Descripción de la sublínea a la cual pertenece el ítem',
  `MODELO` varchar(80) DEFAULT NULL COMMENT 'Descripción del modelo al cual pertenece el ítem',
  `FAMILIA` varchar(80) DEFAULT NULL COMMENT 'Descripción de la familia a la cual pertenece el ítem',
  `SUBFAMILIA` varchar(80) DEFAULT NULL COMMENT 'Descripción de la subfamilia a la cual pertenece el ítem',
  `CATEGORIA` varchar(80) DEFAULT NULL COMMENT 'Descripción de la categoría a la cual pertenece el ítem',
  `TIPO` varchar(80) DEFAULT NULL COMMENT 'Descripción del tipo al cual pertenece el ítem',
  `MARCA` varchar(80) DEFAULT NULL COMMENT 'Descripción de la marca a la cual pertenece el ítem',
  `CAT MANAGEMENT` varchar(80) DEFAULT NULL COMMENT 'Descripción de la categoría management a la cual pertenece el ítem',
  `FECHA` date NOT NULL,
  `CTV` decimal(7,2) DEFAULT NULL,
  `BUFFER` decimal(8,2) DEFAULT NULL,
  `ULTIMO BUFFER` decimal(8,2) DEFAULT NULL,
  `ZONA AMARILLA` decimal(8,2) DEFAULT NULL,
  `ZONA ROJA` decimal(8,2) DEFAULT NULL,
  `COLOR INV FIS` char(1) DEFAULT NULL,
  `COLOR INV PROY` char(1) DEFAULT NULL,
  `INVENTARIO FISICO` decimal(10,2) DEFAULT NULL,
  `TRANSITO` decimal(10,2) DEFAULT NULL,
  `COMPROMETIDO` decimal(10,2) DEFAULT NULL,
  `BACKORDER` decimal(10,2) DEFAULT NULL,
  `INVENTARIO PROYECTADO` decimal(8,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for calendario_estacional
-- ----------------------------
DROP TABLE IF EXISTS `calendario_estacional`;
CREATE TABLE `calendario_estacional` (
  `calendario_estacional_id` int(11) NOT NULL AUTO_INCREMENT,
  `cal_empresa_id` int(11) DEFAULT NULL,
  `cal_nombre` varchar(150) DEFAULT NULL,
  `cal_tipo` char(3) DEFAULT NULL,
  `cal_inicio` int(2) DEFAULT NULL,
  `cal_pico` int(2) DEFAULT NULL,
  `cal_declive` int(2) DEFAULT NULL,
  `cal_normal` int(2) DEFAULT NULL,
  `cal_subidas` int(1) DEFAULT NULL,
  `cal_bajadas` int(1) DEFAULT NULL,
  `cal_porcentaje_cambio` decimal(10,2) DEFAULT NULL,
  `cal_notas` text,
  PRIMARY KEY (`calendario_estacional_id`),
  UNIQUE KEY `NR_cal_empresa_id_cal_nombre` (`cal_empresa_id`,`cal_nombre`) USING BTREE,
  KEY `FK_empresa` (`cal_empresa_id`),
  CONSTRAINT `FK_empresa` FOREIGN KEY (`cal_empresa_id`) REFERENCES `empresa` (`empresa_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for calendar_table
-- ----------------------------
DROP TABLE IF EXISTS `calendar_table`;
CREATE TABLE `calendar_table` (
  `dt` date NOT NULL,
  `y` smallint(6) DEFAULT NULL,
  `q` tinyint(4) DEFAULT NULL,
  `m` tinyint(4) DEFAULT NULL,
  `d` tinyint(4) DEFAULT NULL,
  `dw` tinyint(4) DEFAULT NULL,
  `monthName` varchar(10) DEFAULT NULL,
  `dayName` varchar(9) DEFAULT NULL,
  `w` tinyint(4) DEFAULT NULL,
  `isWeekday` smallint(1) DEFAULT NULL,
  `isHoliday` smallint(1) DEFAULT NULL,
  `holidayDescr` varchar(32) DEFAULT NULL,
  `isPayday` smallint(1) DEFAULT NULL,
  PRIMARY KEY (`dt`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for campo
-- ----------------------------
DROP TABLE IF EXISTS `campo`;
CREATE TABLE `campo` (
  `campo_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Identificados único del campo',
  `cam_nombre` varchar(70) DEFAULT NULL COMMENT 'Nombre del Campo en la Hoja CB',
  `cam_tipo` varchar(15) DEFAULT NULL,
  `cam_notas` text COMMENT 'Comentarios sobre el campo',
  PRIMARY KEY (`campo_id`),
  UNIQUE KEY `FK_cam_nombre_cam_tipo` (`cam_nombre`,`cam_tipo`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=380 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for causa
-- ----------------------------
DROP TABLE IF EXISTS `causa`;
CREATE TABLE `causa` (
  `causa_id` int(11) NOT NULL AUTO_INCREMENT,
  `cau_tipocausa_id` int(11) DEFAULT NULL,
  `cau_nombre` varchar(100) DEFAULT NULL,
  `cau_notas` text,
  PRIMARY KEY (`causa_id`),
  UNIQUE KEY `IN_NoRepetidos` (`cau_nombre`,`cau_tipocausa_id`) USING BTREE,
  KEY `FK_cau_tipocausa_id` (`cau_tipocausa_id`),
  CONSTRAINT `FK_cau_tipocausa_id` FOREIGN KEY (`cau_tipocausa_id`) REFERENCES `tipocausa` (`tipocausa_id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for centro_trabajo
-- ----------------------------
DROP TABLE IF EXISTS `centro_trabajo`;
CREATE TABLE `centro_trabajo` (
  `centro_trabajo_id` int(11) NOT NULL AUTO_INCREMENT,
  `ctr_nombre` varchar(30) DEFAULT NULL,
  `ctr_calendario_id` int(11) DEFAULT NULL,
  `ctr_tipo` varchar(20) DEFAULT NULL,
  `ctr_empresa_id` int(11) DEFAULT NULL,
  `ctr_planta_id` int(11) DEFAULT NULL,
  `ctr_unidades` tinyint(4) DEFAULT NULL,
  `ctr_notas` text,
  PRIMARY KEY (`centro_trabajo_id`),
  UNIQUE KEY `IN_No_Repetidos` (`ctr_nombre`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for compra
-- ----------------------------
DROP TABLE IF EXISTS `compra`;
CREATE TABLE `compra` (
  `compra_id` int(11) NOT NULL,
  `com_bodega_id` int(11) DEFAULT NULL,
  `com_cantidad` varchar(255) DEFAULT NULL,
  `com_orden_id` int(11) DEFAULT NULL,
  `com_proveedor_id` int(11) DEFAULT NULL,
  `com_tipoorden` varchar(255) DEFAULT NULL,
  `com_fecha` varchar(255) DEFAULT NULL,
  `com_producto_id` int(11) DEFAULT NULL,
  `com_tipobuffer` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`compra_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for consumo
-- ----------------------------
DROP TABLE IF EXISTS `consumo`;
CREATE TABLE `consumo` (
  `COD_EMPRESA` varchar(255) DEFAULT NULL,
  `COD_BODEGA` varchar(255) DEFAULT NULL,
  `COD_PRODUCTO` varchar(255) DEFAULT NULL,
  `FECHA_MES` varchar(255) DEFAULT NULL,
  `INGRESOS` varchar(255) DEFAULT NULL,
  `EGRESOS` varchar(255) DEFAULT NULL,
  `DEVOLUCIONES` varchar(255) DEFAULT NULL,
  `FECHA_ACTUALIZACION` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for datos_consolidados
-- ----------------------------
DROP TABLE IF EXISTS `datos_consolidados`;
CREATE TABLE `datos_consolidados` (
  `datos_consolidados_id` int(11) NOT NULL AUTO_INCREMENT,
  `con_empresa` varchar(50) DEFAULT NULL,
  `con_archivo` varchar(100) DEFAULT NULL,
  `con_bodega` varchar(100) DEFAULT NULL,
  `con_proveedor` varchar(150) DEFAULT NULL,
  `con_perfil` varchar(150) DEFAULT NULL,
  `con_codigo` varchar(18) DEFAULT NULL,
  `con_codigo_generico` varchar(18) DEFAULT NULL,
  `con_codigo_vinculado` varchar(18) DEFAULT NULL,
  `con_nuevo_buffer_sugerido` decimal(10,2) DEFAULT NULL,
  `con_nuevo_buffer_real` decimal(10,2) DEFAULT NULL,
  `con_observaciones` varchar(150) DEFAULT NULL,
  `con_tipo` varchar(100) DEFAULT NULL,
  `con_ctv` decimal(10,2) DEFAULT NULL,
  `con_pv` decimal(10,2) DEFAULT NULL,
  `con_pedido_minimo` decimal(10,2) DEFAULT NULL,
  `con_pedido_minimo_grupo` decimal(10,2) DEFAULT NULL,
  `con_unidad_empaque` decimal(10,2) DEFAULT NULL,
  `con_porcentaje_atencion` decimal(10,2) DEFAULT NULL,
  `con_inventario_proveedor` decimal(13,2) DEFAULT NULL,
  `con_buffer` decimal(10,2) DEFAULT NULL,
  `con_inventario_fisico` decimal(10,2) DEFAULT NULL,
  `con_color` char(1) DEFAULT NULL,
  `con_estado_buffer` decimal(10,2) DEFAULT NULL,
  `con_transito` decimal(10,2) DEFAULT NULL,
  `con_negociacion` decimal(10,2) DEFAULT NULL,
  `con_produccion` decimal(10,2) DEFAULT NULL,
  `con_embarcado` decimal(10,2) DEFAULT NULL,
  `con_comprometido` decimal(10,2) DEFAULT NULL,
  `con_backorder` decimal(10,2) DEFAULT NULL,
  `con_inventario_proyectado` decimal(10,2) DEFAULT NULL,
  `con_pedido_calculado` decimal(10,2) DEFAULT NULL,
  `con_pedido_real` decimal(10,2) DEFAULT NULL,
  `con_pedido_promedio` decimal(10,2) DEFAULT NULL,
  `con_tdd` decimal(10,2) DEFAULT NULL,
  `con_idd` decimal(10,2) DEFAULT NULL,
  `con_rentabilidad` decimal(10,2) DEFAULT NULL,
  `con_velocity` decimal(10,2) DEFAULT NULL,
  `con_nivel_servicio` decimal(10,2) DEFAULT NULL,
  `con_ultimo_cambio` date DEFAULT NULL,
  `con_tipo_compra` varchar(50) DEFAULT NULL,
  `con_consumo` decimal(10,2) DEFAULT NULL,
  `con_ped_prom` decimal(10,2) DEFAULT NULL,
  `con_fin` decimal(10,2) DEFAULT NULL,
  `con_gdb` tinyint(4) DEFAULT NULL,
  `con_cam` char(3) DEFAULT NULL,
  `con_comportamiento` varchar(15) DEFAULT NULL,
  `con_consumo1` decimal(10,2) DEFAULT NULL,
  `con_buffer_calculado` decimal(10,2) DEFAULT NULL,
  `con_cobertura_buffer` decimal(10,2) DEFAULT NULL,
  `con_cobertura_inventario_proyectado` decimal(10,2) DEFAULT NULL,
  `con_cobertura_pedido_minimo` decimal(10,2) DEFAULT NULL,
  `con_dias_desabastecimiento` int(11) DEFAULT NULL,
  `con_buffer_minimo` decimal(10,2) DEFAULT NULL,
  `con_buffer_maximo` decimal(10,2) DEFAULT NULL,
  `con_impacto_faltante` decimal(10,2) DEFAULT NULL,
  `con_zona_amarilla` decimal(10,2) DEFAULT NULL,
  `con_zona_roja` decimal(10,2) DEFAULT NULL,
  `con_color1` char(1) DEFAULT NULL,
  `con_ultimo_buffer` decimal(10,2) DEFAULT NULL,
  `con_buffer_anterior_estacion` decimal(10,2) DEFAULT NULL,
  `con_buffer_estacional` decimal(10,2) DEFAULT NULL,
  `con_estado_buffer_proyectado` decimal(10,2) DEFAULT NULL,
  `con_calendario_estacional` varchar(100) DEFAULT NULL,
  `con_accion_estacional` varchar(200) DEFAULT NULL,
  `con_etapa_estacional` varchar(100) DEFAULT NULL,
  `con_rentabilidad_proyectada` decimal(10,2) DEFAULT NULL,
  `con_inicio_horizonte` date DEFAULT NULL,
  `con_fin_horizonte` date DEFAULT NULL,
  `con_variabilidad` decimal(10,2) DEFAULT NULL,
  `con_rojo_acumulado` decimal(10,2) DEFAULT NULL,
  `con_negro` decimal(3,2) DEFAULT NULL,
  `con_rojo` decimal(3,2) DEFAULT NULL,
  `con_amarillo` decimal(3,2) DEFAULT NULL,
  `con_verde` decimal(3,2) DEFAULT NULL,
  `con_lila` decimal(3,2) DEFAULT NULL,
  `con_ingresos` decimal(10,2) DEFAULT NULL,
  `con_egresos` decimal(10,2) DEFAULT NULL,
  `con_pospone_alerta_buf` date DEFAULT NULL,
  `con_pospone_alerta_red` date DEFAULT NULL,
  `con_pospone_alerta_gdb` date DEFAULT NULL,
  `con_estatus` varchar(4) DEFAULT NULL,
  `con_ultima_transferencia_ini` date DEFAULT NULL,
  `con_ultima_transferencia_fin` date DEFAULT NULL,
  PRIMARY KEY (`datos_consolidados_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for empresa
-- ----------------------------
DROP TABLE IF EXISTS `empresa`;
CREATE TABLE `empresa` (
  `empresa_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Identificador único de la empresa generado por el sistema.',
  `emp_nivelacceso_id` varchar(15) DEFAULT NULL COMMENT 'FK que define el nivel de acceso.',
  `emp_grupoacceso_id` varchar(15) DEFAULT NULL COMMENT 'FK que define el grupo de acceso',
  `emp_usuarioacceso_id` varchar(15) DEFAULT NULL COMMENT 'FK que define el usuario de acceso',
  `emp_codigo` varchar(30) DEFAULT NULL COMMENT 'Código de la empresa, generalmente es propio como el RUC.',
  `emp_nombre` varchar(30) DEFAULT NULL COMMENT 'Nombre simplificado de la empresa.',
  `emp_nombrecompleto` varchar(50) DEFAULT NULL COMMENT 'Nombre completo de la empresa.',
  `emp_activa` tinyint(1) DEFAULT '1' COMMENT 'Identifica si la empresa está activa o no.',
  `emp_usuario` varchar(50) DEFAULT NULL,
  `emp_notas` text COMMENT 'Notas sobre la empresa.',
  PRIMARY KEY (`empresa_id`),
  UNIQUE KEY `IN_ND_emp_nombre` (`emp_nombre`) USING BTREE,
  UNIQUE KEY `IN_ND_emp_codigo` (`emp_codigo`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for familia_producto
-- ----------------------------
DROP TABLE IF EXISTS `familia_producto`;
CREATE TABLE `familia_producto` (
  `familia_producto_id` int(11) NOT NULL AUTO_INCREMENT,
  `fap_nombre` varchar(50) DEFAULT NULL,
  `fap_buffer_embarque` decimal(10,2) DEFAULT NULL,
  `fap_notas` text,
  PRIMARY KEY (`familia_producto_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for filtrado
-- ----------------------------
DROP TABLE IF EXISTS `filtrado`;
CREATE TABLE `filtrado` (
  `Empresa` varchar(255) DEFAULT NULL,
  `Archivo` varchar(255) DEFAULT NULL,
  `Bodega` varchar(255) DEFAULT NULL,
  `Proveedor` varchar(255) DEFAULT NULL,
  `Perfil` varchar(255) DEFAULT NULL,
  `Codigo` varchar(255) DEFAULT NULL,
  `CODIGO GENERICO` varchar(255) DEFAULT NULL,
  `CODIGO VINCULADO` varchar(255) DEFAULT NULL,
  `GDB` varchar(255) DEFAULT NULL,
  `Cam` varchar(255) DEFAULT NULL,
  `Comportamiento` varchar(255) DEFAULT NULL,
  `Consumo1` varchar(255) DEFAULT NULL,
  `Buff Calc` varchar(255) DEFAULT NULL,
  `Cobertura Buffer` varchar(255) DEFAULT NULL,
  `Cobertura Inv Proy` varchar(255) DEFAULT NULL,
  `Cobertura Ped Min` varchar(255) DEFAULT NULL,
  `Días Desabastecimiento` varchar(255) DEFAULT NULL,
  `Buff Min` varchar(255) DEFAULT NULL,
  `Buff Max` varchar(255) DEFAULT NULL,
  `Impacto Faltante` varchar(255) DEFAULT NULL,
  `Zona Amar` varchar(255) DEFAULT NULL,
  `Zona Roja` varchar(255) DEFAULT NULL,
  `Color1` varchar(255) DEFAULT NULL,
  `Ult Buffer` varchar(255) DEFAULT NULL,
  `Buff Ant Estacion` varchar(255) DEFAULT NULL,
  `Buff Estacional` varchar(255) DEFAULT NULL,
  `Estado Buffer Proy` varchar(255) DEFAULT NULL,
  `Calendario Estacional` varchar(255) DEFAULT NULL,
  `Acción Estacional` varchar(255) DEFAULT NULL,
  `Etapa Estacional` varchar(255) DEFAULT NULL,
  `Rentabilidad Proy` varchar(255) DEFAULT NULL,
  `Inicio Per` varchar(255) DEFAULT NULL,
  `Fin Per` varchar(255) DEFAULT NULL,
  `Var` varchar(255) DEFAULT NULL,
  `Rojo Acum` varchar(255) DEFAULT NULL,
  `Negro` varchar(255) DEFAULT NULL,
  `Rojo` varchar(255) DEFAULT NULL,
  `Amarillo` varchar(255) DEFAULT NULL,
  `Verde` varchar(255) DEFAULT NULL,
  `Lila` varchar(255) DEFAULT NULL,
  `Ingresos` varchar(255) DEFAULT NULL,
  `Egresos` varchar(255) DEFAULT NULL,
  `Posponer BUF` varchar(255) DEFAULT NULL,
  `Posponer RED` varchar(255) DEFAULT NULL,
  `Posponer GDB` varchar(255) DEFAULT NULL,
  `Estatus` varchar(255) DEFAULT NULL,
  `Ult Transfer Inicial` varchar(255) DEFAULT NULL,
  `Ult Transfer Final` varchar(255) DEFAULT NULL,
  `Nuevo Buff Sug` varchar(255) DEFAULT NULL,
  `Nuevo Buff Real` varchar(255) DEFAULT NULL,
  `Observaciones` varchar(255) DEFAULT NULL,
  `Tipo` varchar(255) DEFAULT NULL,
  `CTV` varchar(255) DEFAULT NULL,
  `PV` varchar(255) DEFAULT NULL,
  `PEDID Min` varchar(255) DEFAULT NULL,
  `PEDID Min Grupo` varchar(255) DEFAULT NULL,
  `Unidad Empaque` varchar(255) DEFAULT NULL,
  `Porc Aten` varchar(255) DEFAULT NULL,
  `Inv Proveed` varchar(255) DEFAULT NULL,
  `Buff Act` varchar(255) DEFAULT NULL,
  `Inv Fís Act` varchar(255) DEFAULT NULL,
  `Color` varchar(255) DEFAULT NULL,
  `Estado Buffer` varchar(255) DEFAULT NULL,
  `Tráns Act` varchar(255) DEFAULT NULL,
  `Negociación` varchar(255) DEFAULT NULL,
  `Producción` varchar(255) DEFAULT NULL,
  `Embarcado` varchar(255) DEFAULT NULL,
  `Comprom` varchar(255) DEFAULT NULL,
  `Backorders` varchar(255) DEFAULT NULL,
  `Inv Proy Act` varchar(255) DEFAULT NULL,
  `PEDIDCalc` varchar(255) DEFAULT NULL,
  `PEDID Real` varchar(255) DEFAULT NULL,
  `PEDID Prom` varchar(255) DEFAULT NULL,
  `T$D` varchar(255) DEFAULT NULL,
  `I$D` varchar(255) DEFAULT NULL,
  `Rentabilid` varchar(255) DEFAULT NULL,
  `Vel Efect` varchar(255) DEFAULT NULL,
  `Servicio` varchar(255) DEFAULT NULL,
  `Ult Cambio` varchar(255) DEFAULT NULL,
  `TipoCompra` varchar(255) DEFAULT NULL,
  `Consumo` varchar(255) DEFAULT NULL,
  `Ped Prom` varchar(255) DEFAULT NULL,
  `FIN` varchar(255) DEFAULT NULL,
  `Comprom Total` varchar(255) DEFAULT NULL,
  `Req Comp 1` varchar(255) DEFAULT NULL,
  `Req Comp 1 Total` varchar(255) DEFAULT NULL,
  `Req Comp 2` varchar(255) DEFAULT NULL,
  `Req Comp 2 Total` varchar(255) DEFAULT NULL,
  `R Complejo` varchar(255) DEFAULT NULL,
  `Requerimiento` varchar(255) DEFAULT NULL,
  `RequerimientoTotal` varchar(255) DEFAULT NULL,
  `ReqTotal` varchar(255) DEFAULT NULL,
  `%Cons Total` varchar(255) DEFAULT NULL,
  `%Consumo` varchar(255) DEFAULT NULL,
  `%Req` varchar(255) DEFAULT NULL,
  `Req a Buffer` varchar(255) DEFAULT NULL,
  `%Req a Buff Total` varchar(255) DEFAULT NULL,
  `%Req a Buff` varchar(255) DEFAULT NULL,
  `Prioridad Abs` varchar(255) DEFAULT NULL,
  `Priorid Abs Total` varchar(255) DEFAULT NULL,
  `Priorid Relat` varchar(255) DEFAULT NULL,
  `Asignado Base` varchar(255) DEFAULT NULL,
  `Asignado Base Total` varchar(255) DEFAULT NULL,
  `Asignado Menos` varchar(255) DEFAULT NULL,
  `Asignado Menos Total` varchar(255) DEFAULT NULL,
  `Req Aux 1` varchar(255) DEFAULT NULL,
  `Req Aux 1 Total` varchar(255) DEFAULT NULL,
  `Req Aux 2` varchar(255) DEFAULT NULL,
  `Req Aux 2 Total` varchar(255) DEFAULT NULL,
  `Req Aux 3` varchar(255) DEFAULT NULL,
  `Req Aux 3 Total` varchar(255) DEFAULT NULL,
  `Req Aux 4` varchar(255) DEFAULT NULL,
  `Req Aux 4 Total` varchar(255) DEFAULT NULL,
  `Req Aux 5` varchar(255) DEFAULT NULL,
  `Req Aux 5 Total` varchar(255) DEFAULT NULL,
  `Req Aux 6` varchar(255) DEFAULT NULL,
  `Req Aux 6 Total` varchar(255) DEFAULT NULL,
  `Req Aux 7` varchar(255) DEFAULT NULL,
  `Req Aux 7 Total` varchar(255) DEFAULT NULL,
  `Req Aux 8` varchar(255) DEFAULT NULL,
  `Req Aux 8 Total` varchar(255) DEFAULT NULL,
  `Req Aux 9` varchar(255) DEFAULT NULL,
  `Req Aux 9 Total` varchar(255) DEFAULT NULL,
  `Req Aux 10` varchar(255) DEFAULT NULL,
  `Req Aux 10 Total` varchar(255) DEFAULT NULL,
  `Req Aux 11` varchar(255) DEFAULT NULL,
  `Req Aux 11 Total` varchar(255) DEFAULT NULL,
  `Req Aux 12` varchar(255) DEFAULT NULL,
  `REQ SIN VBA` varchar(255) DEFAULT NULL,
  `REQ NETO` varchar(255) DEFAULT NULL,
  `Dif REQ NETO` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for histinventarios
-- ----------------------------
DROP TABLE IF EXISTS `histinventarios`;
CREATE TABLE `histinventarios` (
  `IdHistinventarios` bigint(20) NOT NULL AUTO_INCREMENT,
  `EMPRESA` varchar(30) NOT NULL DEFAULT '',
  `CODIGO` varchar(40) NOT NULL DEFAULT '',
  `BODEGA` varchar(40) NOT NULL DEFAULT '',
  `FECHA` date NOT NULL,
  `Archivo` varchar(50) NOT NULL DEFAULT '',
  `NuevoBuffSug` double(10,2) DEFAULT NULL,
  `NuevoBuffReal` double(10,2) DEFAULT NULL,
  `Observaciones` varchar(255) DEFAULT NULL,
  `Tipo` varchar(30) DEFAULT NULL,
  `CTV` decimal(10,2) DEFAULT NULL,
  `PV` decimal(10,2) DEFAULT NULL,
  `InvProveed` double(12,2) DEFAULT NULL,
  `BuffAct` double(10,2) DEFAULT NULL,
  `Color` varchar(1) DEFAULT NULL,
  `InvFisAct` double(10,2) DEFAULT NULL,
  `TransAct` double(10,2) DEFAULT NULL,
  `Comprom` double(10,2) DEFAULT NULL,
  `Backorders` double(10,2) DEFAULT NULL,
  `InvProyAct` double(10,2) DEFAULT NULL,
  `PEDIDCalc` double(10,2) DEFAULT NULL,
  `PEDIDReal` double(10,2) DEFAULT NULL,
  `PEDIDProm` double(10,2) DEFAULT NULL,
  `T$D` double(10,2) DEFAULT NULL,
  `I$D` double(10,2) DEFAULT NULL,
  `Rentabilid` double(15,5) DEFAULT NULL,
  `VelEfect` double(10,2) DEFAULT NULL,
  `Servicio` double(10,2) DEFAULT NULL,
  `UltCambio` date DEFAULT NULL,
  `RojoAcum` double(10,2) DEFAULT NULL,
  `Negro` double(10,2) DEFAULT NULL,
  `Rojo` double(10,2) DEFAULT NULL,
  `Amarillo` double(10,2) DEFAULT NULL,
  `Verde` double(10,2) DEFAULT NULL,
  `Lila` double(10,2) DEFAULT NULL,
  `ZonaAmar` double(10,2) DEFAULT NULL,
  `ZonaRoja` double(10,2) DEFAULT NULL,
  `Entradas` decimal(10,2) DEFAULT NULL,
  `Salidas` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`IdHistinventarios`),
  UNIQUE KEY `IN_Histinventarios` (`EMPRESA`,`CODIGO`,`BODEGA`,`FECHA`) USING BTREE,
  KEY `IN_Fecha` (`FECHA`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for historialbuffer
-- ----------------------------
DROP TABLE IF EXISTS `historialbuffer`;
CREATE TABLE `historialbuffer` (
  `hisbuffer_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `hbu_empresa_id` varchar(18) NOT NULL DEFAULT '',
  `hbu_codigo` varchar(40) NOT NULL DEFAULT '',
  `hbu_bodega_id` varchar(18) NOT NULL DEFAULT '',
  `hbu_fecha` date NOT NULL,
  `hbu_nuevo_buff_sug` decimal(10,2) DEFAULT NULL,
  `hbu_ctv` decimal(10,2) DEFAULT NULL,
  `hbu_pv` decimal(10,2) DEFAULT NULL,
  `hbu_inventario_proveedor` decimal(12,2) DEFAULT NULL,
  `hbu_buffer_actual` decimal(10,2) DEFAULT NULL,
  `hbu_color` char(1) DEFAULT NULL,
  `hbu_inventario_fisico` decimal(10,2) DEFAULT NULL,
  `hbu_transito` decimal(10,2) DEFAULT NULL,
  `hbu_comprometido` decimal(10,2) DEFAULT NULL,
  `hbu_backorder` decimal(10,2) DEFAULT NULL,
  `hbu_pedido_promedio` decimal(10,2) DEFAULT NULL,
  `hbu_pedido_calculado` decimal(10,2) DEFAULT NULL,
  `hbu_T$D` decimal(10,2) DEFAULT NULL,
  `hbu_I$D` decimal(10,2) DEFAULT NULL,
  `hbu_rentabilidad` decimal(15,5) DEFAULT NULL,
  `hbu_velocidad_efectivo` decimal(10,2) DEFAULT NULL,
  `hbu_nivel_de _servicio` decimal(10,2) DEFAULT NULL,
  `hbu_ultimo_cambio_buffer` date DEFAULT NULL,
  `hbu_rojo_acumulado` decimal(10,2) DEFAULT NULL,
  `Negro` decimal(10,2) DEFAULT NULL,
  `Rojo` decimal(10,2) DEFAULT NULL,
  `Amarillo` decimal(10,2) DEFAULT NULL,
  `Verde` decimal(10,2) DEFAULT NULL,
  `Lila` decimal(10,2) DEFAULT NULL,
  `ZonaAmar` decimal(10,2) DEFAULT NULL,
  `ZonaRoja` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`hisbuffer_id`),
  UNIQUE KEY `IN_Histinventarios` (`hbu_empresa_id`,`hbu_codigo`,`hbu_bodega_id`,`hbu_fecha`) USING BTREE,
  KEY `IN_Fecha` (`hbu_fecha`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for historialcausas
-- ----------------------------
DROP TABLE IF EXISTS `historialcausas`;
CREATE TABLE `historialcausas` (
  `Empresa` varchar(50) NOT NULL,
  `BODEGA` varchar(50) NOT NULL,
  `CODIGO` varchar(40) NOT NULL,
  `FECHA` datetime NOT NULL,
  `Causa` varchar(255) DEFAULT NULL,
  `BufferActual` double(10,2) DEFAULT NULL,
  `BufferNuevo` double(10,2) DEFAULT NULL,
  `Tipo` enum('Sobreinventario','Desabastecimiento','Cambio Buffer') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for historial_causas
-- ----------------------------
DROP TABLE IF EXISTS `historial_causas`;
CREATE TABLE `historial_causas` (
  `historial_causas_id` int(11) NOT NULL AUTO_INCREMENT,
  `hc_empresa_codigo` varchar(15) NOT NULL,
  `hc_bodega_codigo` varchar(30) NOT NULL,
  `hc_codigo` varchar(40) NOT NULL,
  `hc_fecha` datetime NOT NULL,
  `hc_causa` varchar(255) DEFAULT NULL,
  `hc_buffer_actual` double(10,2) DEFAULT NULL,
  `hc_buffer_nuevo` double(10,2) DEFAULT NULL,
  `hc_tipo` enum('Sobreinventario','Desabastecimiento','Cambio Buffer') DEFAULT NULL,
  PRIMARY KEY (`historial_causas_id`),
  KEY `IN_Normal` (`hc_fecha`,`hc_bodega_codigo`,`hc_codigo`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=22993 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for histransfer
-- ----------------------------
DROP TABLE IF EXISTS `histransfer`;
CREATE TABLE `histransfer` (
  `COD_EMPRESA` varchar(255) DEFAULT NULL,
  `COD_TRANSFERENCIA` varchar(255) DEFAULT NULL,
  `COD_BODEGA_ORIGEN` varchar(255) DEFAULT NULL,
  `COD_BODEGA_DESTINO` varchar(255) DEFAULT NULL,
  `FECHA_INICIO` varchar(255) DEFAULT NULL,
  `FECHA_FIN` varchar(255) DEFAULT NULL,
  `CODIGO_PRODUCTO` varchar(255) DEFAULT NULL,
  `CANTIDAD` varchar(255) DEFAULT NULL,
  `CANTIDAD_SUGERIDA` varchar(255) DEFAULT NULL,
  `FECHA_ACTUALIZACION` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for imp_bodega
-- ----------------------------
DROP TABLE IF EXISTS `imp_bodega`;
CREATE TABLE `imp_bodega` (
  `bodega_id` int(15) NOT NULL AUTO_INCREMENT COMMENT 'Identificador único de la bodega generado por el sistema',
  `bod_empresa_id` varchar(15) DEFAULT NULL COMMENT 'FK que define a qué empresa pertenece la bodega',
  `bod_codigo` varchar(30) DEFAULT NULL COMMENT 'Código de la bodega que utiliza la empresa para identificarla',
  `bod_nombre` varchar(60) DEFAULT NULL COMMENT 'Nombre descriptivo de la bodega',
  `bod_activa` tinyint(1) DEFAULT '1' COMMENT 'Define si la bodega está activa o no',
  `bod_es_planta` tinyint(1) DEFAULT '0' COMMENT 'Define si la bodega es una planta',
  `bod_maneja_inventario` tinyint(1) DEFAULT '1' COMMENT 'Define si la bodega maneja y repone inventario',
  `bod_tiene_reposicion` tinyint(1) DEFAULT '1' COMMENT 'Define si la bodega tiene reposiciones de inventario',
  `bod_maneja_exhibicion` tinyint(1) DEFAULT '0' COMMENT 'Identifica si la bodega maneja exhibición',
  `bod_tiene_facturacion` tinyint(1) DEFAULT '0' COMMENT 'Identifica si se puede hacer facturación desde la bodega',
  `bod_es_consignacion` tinyint(1) DEFAULT '0' COMMENT 'Identifica si la bodega es de consignación',
  `bod_es_proveedor` tinyint(1) DEFAULT '0' COMMENT 'Define si la bodega es proveedor de inventario',
  `bod_tipo_reposicion` char(3) DEFAULT NULL COMMENT 'Define el tipo de reposición de la bodega',
  `bod_es_propia` tinyint(1) DEFAULT '1' COMMENT 'Define si la bodega es propia o de otra empresa',
  `bod_transito_propio` tinyint(1) DEFAULT '1' COMMENT 'Define si recibe tránsito del sistema ERP.',
  `bod_transito_externo` tinyint(1) DEFAULT '1' COMMENT 'Define si la bodega maneja transito que viene del sistema de transferencias de RAMCAS.',
  `bod_fecha_actualizacion` date DEFAULT NULL COMMENT 'Fecha en la que se ha actualizado el archivo',
  `bod_notas` text,
  PRIMARY KEY (`bodega_id`),
  UNIQUE KEY `NR_codigo_bodega_empresa` (`bod_empresa_id`,`bod_codigo`,`bod_nombre`) USING BTREE,
  KEY `FK_bod_empresa_id` (`bod_empresa_id`)
) ENGINE=InnoDB AUTO_INCREMENT=194 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for imp_consumo
-- ----------------------------
DROP TABLE IF EXISTS `imp_consumo`;
CREATE TABLE `imp_consumo` (
  `consumo_id` int(11) NOT NULL AUTO_INCREMENT,
  `con_empresa_id` varchar(30) DEFAULT NULL,
  `con_bodega_id` varchar(30) DEFAULT NULL,
  `con_producto_id` varchar(30) DEFAULT NULL,
  `con_fecha_mes` date DEFAULT NULL,
  `con_ingreso` decimal(10,2) DEFAULT NULL,
  `con_egreso` decimal(10,2) DEFAULT NULL,
  `con_devolucion` decimal(10,2) DEFAULT NULL,
  `con_fecha_actualizacion` date DEFAULT NULL,
  PRIMARY KEY (`consumo_id`),
  KEY `IN_Consulta_Consumo` (`con_bodega_id`,`con_producto_id`) USING BTREE,
  KEY `IN_Consulta_Consumo_Global` (`con_bodega_id`,`con_fecha_mes`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=15889 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for imp_empresa
-- ----------------------------
DROP TABLE IF EXISTS `imp_empresa`;
CREATE TABLE `imp_empresa` (
  `empresa_id` int(5) NOT NULL AUTO_INCREMENT COMMENT 'Código de la Empresa.',
  `emp_codigo` varchar(30) NOT NULL COMMENT 'Nombre de la Empresa',
  `emp_nombre` varchar(50) NOT NULL,
  `emp_nombre_completo` varchar(60) DEFAULT NULL,
  `emp_activa` tinyint(1) DEFAULT NULL,
  `emp_notas` text,
  PRIMARY KEY (`empresa_id`),
  UNIQUE KEY `IN_ND_emp_codigo` (`emp_codigo`) USING BTREE,
  UNIQUE KEY `IN_ND_emp_nombre` (`emp_nombre`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for imp_histransfer
-- ----------------------------
DROP TABLE IF EXISTS `imp_histransfer`;
CREATE TABLE `imp_histransfer` (
  `histransfer_id` int(11) NOT NULL AUTO_INCREMENT,
  `htr_empresa_id` varchar(30) DEFAULT NULL,
  `htr_codigo_transferencia` varchar(15) DEFAULT NULL,
  `htr_bodega_origen_id` varchar(30) DEFAULT NULL,
  `htr_bodega_destino_id` varchar(30) DEFAULT NULL,
  `htr_fecha_inicio` date DEFAULT NULL,
  `htr_fecha_fin` date DEFAULT NULL,
  `htr_producto_id` varchar(30) DEFAULT NULL,
  `htr_cantidad` decimal(10,2) DEFAULT NULL,
  `htr_cantidad_sugerida` decimal(10,2) DEFAULT NULL,
  `htr_fecha_actualizacion` date DEFAULT NULL,
  PRIMARY KEY (`histransfer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for imp_inventario
-- ----------------------------
DROP TABLE IF EXISTS `imp_inventario`;
CREATE TABLE `imp_inventario` (
  `inventario_id` int(15) NOT NULL AUTO_INCREMENT COMMENT 'Identificador de la Transacción',
  `inv_empresa_id` varchar(30) DEFAULT NULL COMMENT 'Código propio de la empresa, puede ser RUC o cualquier otro identificador único.',
  `inv_bodega_id` varchar(30) DEFAULT NULL COMMENT 'Código propio de la bodega (AGENCIA)',
  `inv_producto_id` varchar(30) DEFAULT NULL COMMENT 'Código propio del ítem',
  `inv_existencia` decimal(12,4) DEFAULT NULL COMMENT 'Inventario físico disponible del ítem en la bodega',
  `inv_transito` decimal(12,4) DEFAULT NULL COMMENT 'Inventario en tránsito del ítem hacia la bodega',
  `inv_negociacion` decimal(12,4) DEFAULT NULL,
  `inv_produccion` decimal(12,4) DEFAULT NULL,
  `inv_embarcado` decimal(12,4) DEFAULT NULL,
  `inv_comprometido` decimal(12,4) DEFAULT NULL COMMENT 'Inventario que se ha comprometido a entregar por parte de la bodega a su cliente',
  `inv_backorder` decimal(12,4) DEFAULT NULL COMMENT 'Inventario que nuestro proveedor se ha comprometido a entregar a la bodega',
  `inv_entradas` decimal(12,4) DEFAULT NULL COMMENT 'Suma de los Ingresos de Inventario del día a la bodega',
  `inv_salidas` decimal(12,4) DEFAULT NULL COMMENT 'Suma de los Egresos de Inventario del día de la bodega',
  `inv_consumo` decimal(12,4) DEFAULT NULL COMMENT 'Suma de los Egresos o Consumos de inventario de los últimos 4 meses. Reemplaza a la tabla HistorialConsumo.txt',
  `inv_ventas_perdidas` decimal(12,4) DEFAULT NULL,
  `inv_buffer_empresa` decimal(12,4) DEFAULT NULL,
  `inv_fecha_actualizacion` date DEFAULT NULL COMMENT 'Fecha en la que se ha actualizado el archivo',
  `inv_notas` text COMMENT 'Notas referentes al inventario',
  PRIMARY KEY (`inventario_id`),
  KEY `IN_Normal` (`inv_bodega_id`,`inv_producto_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=13990 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for imp_producto
-- ----------------------------
DROP TABLE IF EXISTS `imp_producto`;
CREATE TABLE `imp_producto` (
  `producto_id` int(15) NOT NULL AUTO_INCREMENT,
  `pro_empresa_id` varchar(30) DEFAULT NULL COMMENT 'FK que define a qué empresa pertenece el SKU.',
  `pro_codigo` varchar(30) DEFAULT NULL COMMENT 'Código propio del SKU.',
  `pro_codigovinculado` varchar(40) DEFAULT NULL COMMENT 'Código del ítem que reemplaza al actual.',
  `pro_codigogenerico` varchar(40) DEFAULT NULL COMMENT 'Código que agrupa varios ítems que pertenecen a un buffer genérico.',
  `pro_codigopromocion` varchar(40) DEFAULT NULL COMMENT 'Código de la promoción a la cual pertenece el ítem',
  `pro_descripcion` varchar(255) DEFAULT NULL COMMENT 'Nombre completo del producto',
  `pro_grupo_id` varchar(30) DEFAULT NULL COMMENT 'Código del grupo al cual pertenece el ítem',
  `pro_grupo` varchar(80) DEFAULT NULL COMMENT 'Descripción del grupo al cual pertenece el ítem',
  `pro_linea_id` varchar(30) DEFAULT NULL COMMENT 'Código de la línea a la cual pertenece el ítem',
  `pro_linea` varchar(80) DEFAULT NULL COMMENT 'Descripción de la línea a la cual pertenece el ítem',
  `pro_sublinea_id` varchar(30) DEFAULT NULL COMMENT 'Código de la sublínea a la cual pertenece el ítem',
  `pro_sublinea` varchar(80) DEFAULT NULL COMMENT 'Descripción de la sublínea a la cual pertenece el ítem',
  `pro_modelo_id` varchar(30) DEFAULT NULL COMMENT 'Código del modelo al cual pertenece el ítem',
  `pro_modelo` varchar(80) DEFAULT NULL COMMENT 'Descripción del modelo al cual pertenece el ítem',
  `pro_familia_id` varchar(30) DEFAULT NULL COMMENT 'Código de la familia a la cual pertenece el ítem',
  `pro_familia` varchar(80) DEFAULT NULL COMMENT 'Descripción de la familia a la cual pertenece el ítem',
  `pro_subfamilia_id` varchar(30) DEFAULT NULL COMMENT 'Código de la subfamilia a la cual pertenece el ítem',
  `pro_subfamilia` varchar(80) DEFAULT NULL COMMENT 'Descripción de la subfamilia a la cual pertenece el ítem',
  `pro_categoria_id` varchar(30) DEFAULT NULL COMMENT 'Código de la categoría a la cual pertenece el ítem',
  `pro_categoria` varchar(80) DEFAULT NULL COMMENT 'Descripción de la categoría a la cual pertenece el ítem',
  `pro_tipo_id` varchar(30) DEFAULT NULL COMMENT 'Código del tipo al cual pertenece el ítem',
  `pro_tipo` varchar(80) DEFAULT NULL COMMENT 'Descripción del tipo al cual pertenece el ítem',
  `pro_marca_id` varchar(30) DEFAULT NULL COMMENT 'Código de la marca a la cual pertenece el ítem',
  `pro_marca` varchar(80) DEFAULT NULL COMMENT 'Descripción de la marca a la cual pertenece el ítem',
  `pro_cat_management_id` varchar(30) DEFAULT NULL COMMENT 'Código de la categoría management a la cual pertenece el ítem',
  `pro_cat_management` varchar(80) DEFAULT NULL COMMENT 'Descripción de la categoría management a la cual pertenece el ítem',
  `pro_catpropia1_id` varchar(30) DEFAULT NULL COMMENT 'Código de la categoría personalizada',
  `pro_catpropia1` varchar(80) DEFAULT NULL COMMENT 'Descripción de la categoría personalizada',
  `pro_catpropia2_id` varchar(30) DEFAULT NULL COMMENT 'Código de la categoría personalizada',
  `pro_catpropia2` varchar(80) DEFAULT NULL COMMENT 'Descripción de la categoría personalizada',
  `pro_catpropia3_id` varchar(30) DEFAULT NULL COMMENT 'Código de la categoría personalizada',
  `pro_catpropia3` varchar(80) DEFAULT NULL COMMENT 'Descripción de la categoría personalizada',
  `pro_catpropia4_id` varchar(30) DEFAULT NULL COMMENT 'Código de la categoría personalizada',
  `pro_catpropia4` varchar(80) DEFAULT NULL COMMENT 'Descripción de la categoría personalizada',
  `pro_catpropia5_id` varchar(30) DEFAULT NULL COMMENT 'Código de la categoría personalizada',
  `pro_catpropia5` varchar(80) DEFAULT NULL COMMENT 'Descripción de la categoría personalizada',
  `pro_tiporeposicion` char(3) DEFAULT NULL COMMENT 'Define si el ítem se fabrica para reposición o para órdenes en firme',
  `pro_peso` decimal(10,2) DEFAULT NULL COMMENT 'Peso del ítem',
  `pro_unidad_peso` varchar(15) DEFAULT NULL COMMENT 'Unidad del peso del ítem',
  `pro_volumen` decimal(10,2) DEFAULT NULL COMMENT 'Volumen del ítem',
  `pro_unidad_volumen` varchar(15) DEFAULT NULL COMMENT 'Unidad de volumen del ítem',
  `pro_activo` tinyint(1) DEFAULT NULL COMMENT 'Define si el ítem está activo',
  `pro_control_buffer` tinyint(1) DEFAULT NULL COMMENT 'Define si el ítem está bajo control de buffers',
  `pro_precio` decimal(10,2) DEFAULT NULL COMMENT 'Precio del ítem',
  `pro_costo` decimal(10,2) DEFAULT NULL COMMENT 'Costo del ítem',
  `pro_truput_total` decimal(10,2) DEFAULT NULL COMMENT 'Trúput obtenido por la venta del ítem en toda la organización en los últimos 365 días. Suma de Ventas - Suma de Costo de Ventas. Reemplaza a la tabla Trúput Anual.txt.',
  `pro_fechadescontinuado` date DEFAULT NULL COMMENT 'Fecha en la que se ha descontinuado el ítem',
  `pro_unidad` varchar(15) DEFAULT NULL COMMENT 'Unidad del sku',
  `pro_estatus` char(3) DEFAULT NULL,
  `pro_clasificacion` varchar(4) DEFAULT NULL,
  `pro_responsable` varchar(10) DEFAULT NULL,
  `pro_precio_promocion` decimal(7,2) DEFAULT NULL,
  `pro_promocion_desde` date DEFAULT NULL,
  `pro_promocion_hasta` date DEFAULT NULL,
  `pro_notas` text COMMENT 'Notas tel ítem',
  `pro_fecha_actualizacion` date DEFAULT NULL COMMENT 'Fecha en la que se ha actualizado el archivo',
  PRIMARY KEY (`producto_id`),
  UNIQUE KEY `IN_Unicos` (`pro_codigo`,`pro_empresa_id`) USING BTREE,
  KEY `IN_Normal` (`pro_codigo`,`pro_empresa_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=14154 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for imp_transaccion
-- ----------------------------
DROP TABLE IF EXISTS `imp_transaccion`;
CREATE TABLE `imp_transaccion` (
  `imp_transaccion_id` varchar(15) NOT NULL COMMENT 'Identificador de la Transacción',
  `itrn_imp_empresa_id` varchar(15) DEFAULT NULL COMMENT 'Código de la empresa',
  `itrn_tipo` varchar(3) DEFAULT NULL COMMENT 'Si es Ingreso (ING), Egreso (EGR) o Devolución (DEV)',
  `itrn_codigo_item` varchar(15) DEFAULT NULL,
  `itrm_bodega_id_origen` varchar(15) DEFAULT NULL COMMENT 'Código de Bodega de Origen',
  `itrm_bodega_id_destino` varchar(15) DEFAULT NULL COMMENT 'Código de Bodega de Destino',
  `itrn_cantidad` decimal(10,2) DEFAULT NULL COMMENT 'Cantidad',
  `itrn_fecha` date DEFAULT NULL,
  PRIMARY KEY (`imp_transaccion_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for ints
-- ----------------------------
DROP TABLE IF EXISTS `ints`;
CREATE TABLE `ints` (
  `i` tinyint(4) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for item_types
-- ----------------------------
DROP TABLE IF EXISTS `item_types`;
CREATE TABLE `item_types` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name_spanish` char(1) NOT NULL,
  `description_spanish` varchar(20) NOT NULL,
  `name_english` char(1) NOT NULL,
  `description_english` varchar(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UN_name_spanish` (`name_spanish`) USING BTREE,
  UNIQUE KEY `UN_name_english` (`name_english`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for orden
-- ----------------------------
DROP TABLE IF EXISTS `orden`;
CREATE TABLE `orden` (
  `orden_id` int(11) NOT NULL,
  `ord_codigo_orden` varchar(20) NOT NULL,
  `ord_fecha` date NOT NULL,
  `ord_tipo` enum('') DEFAULT NULL,
  `ord_fecha_esperada` date DEFAULT NULL,
  `ord_origen` int(11) DEFAULT NULL,
  `ord_destino` int(11) DEFAULT NULL,
  `ord_producto` varchar(20) DEFAULT NULL,
  `ord_cantidad` decimal(8,2) DEFAULT NULL,
  `ord_cantidad_sugerida` decimal(8,2) DEFAULT NULL,
  `ord_costo` decimal(8,2) DEFAULT NULL,
  PRIMARY KEY (`orden_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for orden_produccion_cabecera
-- ----------------------------
DROP TABLE IF EXISTS `orden_produccion_cabecera`;
CREATE TABLE `orden_produccion_cabecera` (
  `orden_produccion_c_id` int(11) NOT NULL AUTO_INCREMENT,
  `opr_centro_trabajo_id` int(11) DEFAULT NULL,
  `opr_codigo` varchar(18) DEFAULT NULL,
  `opr_nombre` varchar(50) DEFAULT NULL,
  `opr_fecha_entrega` date DEFAULT NULL,
  PRIMARY KEY (`orden_produccion_c_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for orden_produccion_detalle
-- ----------------------------
DROP TABLE IF EXISTS `orden_produccion_detalle`;
CREATE TABLE `orden_produccion_detalle` (
  `orden_produccion_d_id` int(11) NOT NULL AUTO_INCREMENT,
  `opr_orden_produccion_c_id` int(11) DEFAULT NULL,
  `opr_producto_id` int(11) DEFAULT NULL,
  `opr_cantidad` int(11) DEFAULT NULL,
  `opr_fecha_entrega` date DEFAULT NULL,
  PRIMARY KEY (`orden_produccion_d_id`),
  KEY `FK_orden_produccion_c_id` (`opr_orden_produccion_c_id`) USING BTREE,
  CONSTRAINT `FK_orden_produccion_c_id` FOREIGN KEY (`opr_orden_produccion_c_id`) REFERENCES `orden_produccion_cabecera` (`orden_produccion_c_id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for orden_venta_cabecera
-- ----------------------------
DROP TABLE IF EXISTS `orden_venta_cabecera`;
CREATE TABLE `orden_venta_cabecera` (
  `orden_venta_c_id` int(11) NOT NULL AUTO_INCREMENT,
  `orv_codigo` varchar(18) DEFAULT NULL,
  `orv_cliente_id` int(11) DEFAULT NULL,
  `orv_vendedor_id` int(11) DEFAULT NULL,
  `orv_fecha_entrega` date DEFAULT NULL,
  `orv_dependiente` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`orden_venta_c_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for orden_venta_detalle
-- ----------------------------
DROP TABLE IF EXISTS `orden_venta_detalle`;
CREATE TABLE `orden_venta_detalle` (
  `orden_venta_d_id` int(11) NOT NULL AUTO_INCREMENT,
  `orv_orden_venta_c_id` int(11) DEFAULT NULL,
  `orv_producto_id` int(11) DEFAULT NULL,
  `orv_cantidad` decimal(10,2) DEFAULT NULL,
  `orv_fecha_entrega` date DEFAULT NULL,
  PRIMARY KEY (`orden_venta_d_id`),
  KEY `FK_orden_venta_c_id` (`orv_orden_venta_c_id`) USING BTREE,
  KEY `FK_producto_id` (`orv_producto_id`) USING BTREE,
  CONSTRAINT `FK_orden_venta_c_id` FOREIGN KEY (`orv_orden_venta_c_id`) REFERENCES `orden_venta_cabecera` (`orden_venta_c_id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_producto_id` FOREIGN KEY (`orv_producto_id`) REFERENCES `producto` (`producto_id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for orden_venta_produccion
-- ----------------------------
DROP TABLE IF EXISTS `orden_venta_produccion`;
CREATE TABLE `orden_venta_produccion` (
  `orden_venta_produccion_id` int(11) NOT NULL AUTO_INCREMENT,
  `ovp_orden_venta_c_id` int(11) DEFAULT NULL,
  `ovp_orden_produccion_c_id` int(11) DEFAULT NULL,
  `ovp_cantidad` decimal(10,2) DEFAULT NULL,
  `ovp_notas` text,
  PRIMARY KEY (`orden_venta_produccion_id`),
  UNIQUE KEY `IN_No_Repetidos` (`ovp_orden_venta_c_id`,`ovp_orden_produccion_c_id`) USING BTREE,
  KEY `FK_orden_produccion_c` (`ovp_orden_produccion_c_id`) USING BTREE,
  CONSTRAINT `FK_orden_produccion_c` FOREIGN KEY (`ovp_orden_produccion_c_id`) REFERENCES `orden_produccion_cabecera` (`orden_produccion_c_id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_orden_venta_c` FOREIGN KEY (`ovp_orden_venta_c_id`) REFERENCES `orden_venta_cabecera` (`orden_venta_c_id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for pais
-- ----------------------------
DROP TABLE IF EXISTS `pais`;
CREATE TABLE `pais` (
  `Country Name` varchar(255) DEFAULT NULL,
  `ISO 3166-1-alpha-2 code` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for parametro
-- ----------------------------
DROP TABLE IF EXISTS `parametro`;
CREATE TABLE `parametro` (
  `parametro_id` int(11) NOT NULL AUTO_INCREMENT,
  `par_nombre` varchar(50) DEFAULT NULL,
  `par_valor` varchar(255) DEFAULT NULL,
  `par_notas` text,
  PRIMARY KEY (`parametro_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for perfilreposicion
-- ----------------------------
DROP TABLE IF EXISTS `perfilreposicion`;
CREATE TABLE `perfilreposicion` (
  `perfilreposicion_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Identificador único sel perfil de reposición.',
  `pre_empresa_id` int(11) DEFAULT NULL COMMENT 'FK que identifica a qué empresa pertenece el perfil de reposición.',
  `pre_tipohorizonte_id` int(11) DEFAULT NULL COMMENT 'FK que identifica qué tipo de horizonte se va a utilizar en el perfil de reposición.',
  `pre_nombre` varchar(50) DEFAULT NULL COMMENT 'Nombre del perfil de reposición.',
  `pre_frecuenciareposicion` decimal(6,2) DEFAULT NULL COMMENT 'Frecuencia de reposición del SKU en semanas.',
  `pre_tiemposuministro` decimal(6,2) DEFAULT NULL COMMENT 'Tiempo de suministro del SKU en semanas.',
  `pre_tiemposervicio` int(5) DEFAULT NULL COMMENT 'Tiempo que se busca el servicio en la base de datos de transferencias. Está en días.',
  `pre_horizonteanalisis` int(5) DEFAULT NULL COMMENT 'Horizonte de análisis del SKU en semanas.',
  `pre_zonaroja` decimal(4,2) DEFAULT NULL COMMENT 'Porcentaje de zona roja en el buffer del SKU.',
  `pre_porcentajepedidominimo` decimal(4,2) DEFAULT NULL COMMENT 'Porcentaje del buffer que debe cumplirse para hacer un pedido mínimo.',
  `pre_pedido_promedio_en_requerimiento` tinyint(1) DEFAULT NULL,
  `pre_usa_fisico` tinyint(1) DEFAULT NULL,
  `pre_usa_transito` tinyint(1) DEFAULT NULL,
  `pre_usa_comprometido` tinyint(1) DEFAULT NULL,
  `pre_usa_backorder` tinyint(1) DEFAULT NULL,
  `pre_tipo_transito` varchar(20) DEFAULT NULL,
  `pre_tipo_backorder` varchar(20) DEFAULT NULL,
  `pre_tipo_comprometido` varchar(20) DEFAULT NULL,
  `pre_tipo_consumo` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`perfilreposicion_id`),
  UNIQUE KEY `IN_pre_nombre` (`pre_empresa_id`,`pre_nombre`) USING BTREE,
  KEY `FK_pre_tipohorizonte_id` (`pre_tipohorizonte_id`),
  CONSTRAINT `FK_pre_empresa_id` FOREIGN KEY (`pre_empresa_id`) REFERENCES `empresa` (`empresa_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_pre_tipohorizonte_id` FOREIGN KEY (`pre_tipohorizonte_id`) REFERENCES `tipohorizonte` (`tipohorizonte_id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for perfil_reposicion
-- ----------------------------
DROP TABLE IF EXISTS `perfil_reposicion`;
CREATE TABLE `perfil_reposicion` (
  `perfil_reposicion_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Identificador único sel perfil de reposición.',
  `pre_empresa_id` int(11) DEFAULT NULL COMMENT 'FK que identifica a qué empresa pertenece el perfil de reposición.',
  `pre_tipohorizonte_id` int(11) DEFAULT NULL COMMENT 'FK que identifica qué tipo de horizonte se va a utilizar en el perfil de reposición.',
  `pre_nombre` varchar(50) DEFAULT NULL COMMENT 'Nombre del perfil de reposición.',
  `pre_frecuencia_reposicion` decimal(6,2) DEFAULT NULL COMMENT 'Frecuencia de reposición del SKU en semanas.',
  `pre_tiempo_suministro` decimal(6,2) DEFAULT NULL COMMENT 'Tiempo de suministro del SKU en semanas.',
  `pre_tiempo_servicio` int(5) DEFAULT NULL COMMENT 'Tiempo que se busca el servicio en la base de datos de transferencias. Está en días.',
  `pre_horizonte_analisis` int(5) DEFAULT NULL COMMENT 'Horizonte de análisis del SKU en semanas.',
  `pre_zona_roja` decimal(4,2) DEFAULT NULL COMMENT 'Porcentaje de zona roja en el buffer del SKU.',
  `pre_porcentaje_pedido_minimo` decimal(4,2) DEFAULT NULL COMMENT 'Porcentaje del buffer que debe cumplirse para hacer un pedido mínimo.',
  `pre_pedido_promedio_en_requerimiento` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`perfil_reposicion_id`),
  UNIQUE KEY `IN_pre_nombre` (`pre_empresa_id`,`pre_nombre`) USING BTREE,
  KEY `FK_pre_tipohorizonte_id` (`pre_tipohorizonte_id`) USING BTREE,
  CONSTRAINT `perfil_reposicion_ibfk_1` FOREIGN KEY (`pre_empresa_id`) REFERENCES `empresa` (`empresa_id`) ON UPDATE CASCADE,
  CONSTRAINT `perfil_reposicion_ibfk_2` FOREIGN KEY (`pre_tipohorizonte_id`) REFERENCES `tipohorizonte` (`tipohorizonte_id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for phprunn_uggroups
-- ----------------------------
DROP TABLE IF EXISTS `phprunn_uggroups`;
CREATE TABLE `phprunn_uggroups` (
  `GroupID` int(11) NOT NULL AUTO_INCREMENT,
  `Label` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`GroupID`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for phprunn_ugmembers
-- ----------------------------
DROP TABLE IF EXISTS `phprunn_ugmembers`;
CREATE TABLE `phprunn_ugmembers` (
  `UserName` varchar(50) NOT NULL,
  `GroupID` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`UserName`,`GroupID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for phprunn_ugrights
-- ----------------------------
DROP TABLE IF EXISTS `phprunn_ugrights`;
CREATE TABLE `phprunn_ugrights` (
  `TableName` varchar(50) NOT NULL,
  `GroupID` int(11) NOT NULL DEFAULT '0',
  `AccessMask` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`TableName`,`GroupID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for po_action_history
-- ----------------------------
DROP TABLE IF EXISTS `po_action_history`;
CREATE TABLE `po_action_history` (
  `OBJECT_ID` int(11) NOT NULL,
  `OBJECT_TYPE_CODE` varchar(255) DEFAULT NULL,
  `OBJECT_SUB_TYPE_CODE` varchar(255) DEFAULT NULL,
  `SEQUENCE_NUM` int(11) DEFAULT NULL,
  PRIMARY KEY (`OBJECT_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for po_distributions_all
-- ----------------------------
DROP TABLE IF EXISTS `po_distributions_all`;
CREATE TABLE `po_distributions_all` (
  `PO_DISTRIBUTION_ID` int(11) NOT NULL,
  `PO_HEADER_ID` int(11) DEFAULT NULL,
  `PO_LINE_ID` int(11) DEFAULT NULL,
  `LINE_LOCATION_ID` int(11) DEFAULT NULL,
  `SET_OF_BOOKS_ID` varchar(255) DEFAULT NULL,
  `CODE_COMBINATION_ID` int(11) DEFAULT NULL,
  `QUANTITY_ORDERED` int(11) DEFAULT NULL,
  `DISTRIBUTION_NUM` int(11) DEFAULT NULL,
  PRIMARY KEY (`PO_DISTRIBUTION_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for po_headers_all
-- ----------------------------
DROP TABLE IF EXISTS `po_headers_all`;
CREATE TABLE `po_headers_all` (
  `PO_HEADER_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Primary key',
  `AGENT_ID` int(11) NOT NULL COMMENT 'Foreign key: HR_EMPLOYEES',
  `TYPE_LOOKUP_CODE` varchar(25) NOT NULL COMMENT 'Foreign Key: PO_LOOKUP_ CODES',
  `LAST_UPDATE_DATE` date NOT NULL,
  `LAST_UPDATED_BY` datetime NOT NULL,
  `SEGMENT1` varchar(20) NOT NULL COMMENT 'PO number',
  `SUMMARY_FLAG` char(1) NOT NULL COMMENT 'N',
  `ENABLED_FLAG` char(1) NOT NULL COMMENT 'Y',
  `VENDOR_ID` int(11) DEFAULT NULL COMMENT 'Foreign key: PO_VENDORS',
  `VENDOR_SITE_ID` int(11) DEFAULT NULL COMMENT 'Foreign key: PO_VENDOR_SITES',
  `TERMS_ID` int(11) DEFAULT NULL,
  `FREIGHT_TERMS_ LOOKUP_CODE` varchar(25) DEFAULT NULL COMMENT 'Foreign key: PO_LOOKUP_ CODES',
  `CURRENCY_CODE` varchar(15) DEFAULT NULL,
  `APPROVED_FLAG` char(1) DEFAULT NULL,
  PRIMARY KEY (`PO_HEADER_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for po_lines_all
-- ----------------------------
DROP TABLE IF EXISTS `po_lines_all`;
CREATE TABLE `po_lines_all` (
  `PO_LINE_ID` int(11) NOT NULL,
  `PO_HEADER_ID` int(11) DEFAULT NULL,
  `LINE_TYPE_ID` int(11) DEFAULT NULL,
  `LINE_NUM` int(11) DEFAULT NULL,
  PRIMARY KEY (`PO_LINE_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for po_line_locations_all
-- ----------------------------
DROP TABLE IF EXISTS `po_line_locations_all`;
CREATE TABLE `po_line_locations_all` (
  `LINE_LOCATION_ID` varchar(255) DEFAULT NULL,
  `LAST_UPDATE_DATE` datetime DEFAULT NULL,
  `LAST_UPDATED_BY` datetime DEFAULT NULL,
  `PO_HEADER_ID` int(11) DEFAULT NULL,
  `PO_LINE_ID` int(11) DEFAULT NULL,
  `SHIPMENT_TYPE` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for po_lookup_codes
-- ----------------------------
DROP TABLE IF EXISTS `po_lookup_codes`;
CREATE TABLE `po_lookup_codes` (
  `PO_LOOKUP_CODES_ID` int(11) NOT NULL,
  `PO_TYPE` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`PO_LOOKUP_CODES_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for po_releases_all
-- ----------------------------
DROP TABLE IF EXISTS `po_releases_all`;
CREATE TABLE `po_releases_all` (
  `PO_RELEASE_ID` int(11) NOT NULL,
  `PO_HEADER_ID` int(11) DEFAULT NULL,
  `RELEASE_NUM` int(11) DEFAULT NULL,
  `AGENT_ID` int(11) DEFAULT NULL,
  `RELEASE_DATE` datetime DEFAULT NULL,
  PRIMARY KEY (`PO_RELEASE_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for po_requisition_headers_all
-- ----------------------------
DROP TABLE IF EXISTS `po_requisition_headers_all`;
CREATE TABLE `po_requisition_headers_all` (
  `REQUISITION_HEADER_ID` int(11) NOT NULL AUTO_INCREMENT,
  `PREPARER_ID` int(11) DEFAULT NULL,
  `SEGMENT1` varchar(255) DEFAULT NULL COMMENT 'SEGMENT1 is the number you use to identify the requisition in forms and reports. Oracle Purchasing generates SEGMENT1 using the PO_UNIQUE_IDENTIFIER_CONTROL table if you choose to let Oracle Purchasing generate requisition numbers for you.',
  `SUMMARY_FLAG` varchar(255) DEFAULT NULL,
  `ENABLED_FLAG` varchar(255) DEFAULT NULL,
  `AUTHORIZATION_STATUS` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`REQUISITION_HEADER_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for po_requisition_lines_all
-- ----------------------------
DROP TABLE IF EXISTS `po_requisition_lines_all`;
CREATE TABLE `po_requisition_lines_all` (
  `REQUISITION_LINE_ID` int(11) NOT NULL,
  `REQUISITION_HEADER_ID` int(11) DEFAULT NULL,
  `LINE_NUM` int(11) DEFAULT NULL,
  `LINE_TYPE_ID` int(11) DEFAULT NULL,
  `CATEGORY_ID` int(11) DEFAULT NULL,
  `ITEM_DESCRIPTION` varchar(255) DEFAULT NULL,
  `UNIT_MEAS_LOOKUP_CODE` varchar(255) DEFAULT NULL,
  `UNIT_PRICE` decimal(10,0) DEFAULT NULL,
  `QUANTITY` varchar(255) DEFAULT NULL,
  `DELIVER_TO_LOCATION_ID` int(11) DEFAULT NULL,
  `TO_PERSON_ID` int(11) DEFAULT NULL,
  `SOURCE_TYPE_CODE` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`REQUISITION_LINE_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for po_req_distributions_all
-- ----------------------------
DROP TABLE IF EXISTS `po_req_distributions_all`;
CREATE TABLE `po_req_distributions_all` (
  `DISTRIBUTION_ID` int(11) NOT NULL,
  `REQUISITION_LINE_ID` int(11) DEFAULT NULL,
  `SET_OF_BOOKS_ID` int(11) DEFAULT NULL,
  `CODE_COMBINATION_ID` int(11) DEFAULT NULL,
  `REQ_LINE_QUANTITY` varchar(255) DEFAULT NULL,
  `DISTRIBUTION_NUM` int(11) DEFAULT NULL,
  PRIMARY KEY (`DISTRIBUTION_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for po_vendors
-- ----------------------------
DROP TABLE IF EXISTS `po_vendors`;
CREATE TABLE `po_vendors` (
  `VENDOR_ID` int(11) NOT NULL,
  `VENDOR_NAME` varchar(255) DEFAULT NULL,
  `SEGMENT1` varchar(255) DEFAULT NULL,
  `SUMMARY_FLAG` varchar(255) DEFAULT NULL,
  `ENABLED_FLAG` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`VENDOR_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for po_vendor_contacts
-- ----------------------------
DROP TABLE IF EXISTS `po_vendor_contacts`;
CREATE TABLE `po_vendor_contacts` (
  `VENDOR_CONTACT_ID` int(11) NOT NULL,
  `VENDOR_SITE_ID` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`VENDOR_CONTACT_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for po_vendor_sites_all
-- ----------------------------
DROP TABLE IF EXISTS `po_vendor_sites_all`;
CREATE TABLE `po_vendor_sites_all` (
  `VENDOR_SITE_ID` int(11) NOT NULL,
  `VENDOR_ID` int(11) DEFAULT NULL,
  `VENDOR_SITE_CODE` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`VENDOR_SITE_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for producto
-- ----------------------------
DROP TABLE IF EXISTS `producto`;
CREATE TABLE `producto` (
  `producto_id` int(15) NOT NULL AUTO_INCREMENT,
  `pro_empresa_id` int(11) DEFAULT NULL COMMENT 'FK que define a qué empresa pertenece el SKU.',
  `pro_familia_producto_id` int(11) DEFAULT NULL,
  `pro_codigo` varchar(15) DEFAULT NULL COMMENT 'Código propio del SKU.',
  `pro_codigovinculado` varchar(15) DEFAULT NULL COMMENT 'Código del ítem que reemplaza al actual.',
  `pro_codigogenerico` varchar(15) DEFAULT NULL COMMENT 'Código que agrupa varios ítems que pertenecen a un buffer genérico.',
  `pro_codigopromocion` varchar(15) DEFAULT NULL COMMENT 'Código de la promoción a la cual pertenece el ítem',
  `pro_descripcion` varchar(255) DEFAULT NULL COMMENT 'Nombre completo del producto',
  `pro_grupo_id` varchar(15) DEFAULT NULL COMMENT 'Código del grupo al cual pertenece el ítem',
  `pro_grupo` varchar(80) DEFAULT NULL COMMENT 'Descripción del grupo al cual pertenece el ítem',
  `pro_linea_id` varchar(15) DEFAULT NULL COMMENT 'Código de la línea a la cual pertenece el ítem',
  `pro_linea` varchar(80) DEFAULT NULL COMMENT 'Descripción de la línea a la cual pertenece el ítem',
  `pro_sublinea_id` varchar(15) DEFAULT NULL COMMENT 'Código de la sublínea a la cual pertenece el ítem',
  `pro_sublinea` varchar(80) DEFAULT NULL COMMENT 'Descripción de la sublínea a la cual pertenece el ítem',
  `pro_modelo_id` varchar(15) DEFAULT NULL COMMENT 'Código del modelo al cual pertenece el ítem',
  `pro_modelo` varchar(80) DEFAULT NULL COMMENT 'Descripción del modelo al cual pertenece el ítem',
  `pro_familia_id` varchar(15) DEFAULT NULL COMMENT 'Código de la familia a la cual pertenece el ítem',
  `pro_familia` varchar(80) DEFAULT NULL COMMENT 'Descripción de la familia a la cual pertenece el ítem',
  `pro_subfamilia_id` varchar(15) DEFAULT NULL COMMENT 'Código de la subfamilia a la cual pertenece el ítem',
  `pro_subfamilia` varchar(80) DEFAULT NULL COMMENT 'Descripción de la subfamilia a la cual pertenece el ítem',
  `pro_categoria_id` varchar(15) DEFAULT NULL COMMENT 'Código de la categoría a la cual pertenece el ítem',
  `pro_categoria` varchar(80) DEFAULT NULL COMMENT 'Descripción de la categoría a la cual pertenece el ítem',
  `pro_tipo_id` varchar(15) DEFAULT NULL COMMENT 'Código del tipo al cual pertenece el ítem',
  `pro_tipo` varchar(80) DEFAULT NULL COMMENT 'Descripción del tipo al cual pertenece el ítem',
  `pro_marca_id` varchar(15) DEFAULT NULL COMMENT 'Código de la marca a la cual pertenece el ítem',
  `pro_marca` varchar(80) DEFAULT NULL COMMENT 'Descripción de la marca a la cual pertenece el ítem',
  `pro_cat_management_id` varchar(15) DEFAULT NULL COMMENT 'Código de la categoría management a la cual pertenece el ítem',
  `pro_cat_management` varchar(80) DEFAULT NULL COMMENT 'Descripción de la categoría management a la cual pertenece el ítem',
  `pro_catpropia1_id` varchar(15) DEFAULT NULL COMMENT 'Código de la categoría personalizada',
  `pro_catpropia1` varchar(80) DEFAULT NULL COMMENT 'Descripción de la categoría personalizada',
  `pro_catpropia2_id` varchar(15) DEFAULT NULL COMMENT 'Código de la categoría personalizada',
  `pro_catpropia2` varchar(80) DEFAULT NULL COMMENT 'Descripción de la categoría personalizada',
  `pro_catpropia3_id` varchar(15) DEFAULT NULL COMMENT 'Código de la categoría personalizada',
  `pro_catpropia3` varchar(80) DEFAULT NULL COMMENT 'Descripción de la categoría personalizada',
  `pro_catpropia4_id` varchar(15) DEFAULT NULL COMMENT 'Código de la categoría personalizada',
  `pro_catpropia4` varchar(80) DEFAULT NULL COMMENT 'Descripción de la categoría personalizada',
  `pro_catpropia5_id` varchar(15) DEFAULT NULL COMMENT 'Código de la categoría personalizada',
  `pro_catpropia5` varchar(80) DEFAULT NULL COMMENT 'Descripción de la categoría personalizada',
  `pro_tiporeposicion` char(3) DEFAULT NULL COMMENT 'Define si el ítem se fabrica para reposición o para órdenes en firme',
  `pro_peso` decimal(10,2) DEFAULT NULL COMMENT 'Peso del ítem',
  `pro_unidad_peso` varchar(15) DEFAULT NULL COMMENT 'Unidad del peso del ítem',
  `pro_volumen` decimal(10,2) DEFAULT NULL COMMENT 'Volumen del ítem',
  `pro_unidad_volumen` varchar(15) DEFAULT NULL COMMENT 'Unidad de volumen del ítem',
  `pro_activo` tinyint(1) DEFAULT NULL COMMENT 'Define si el ítem está activo',
  `pro_control_buffer` tinyint(1) DEFAULT NULL COMMENT 'Define si el ítem está bajo control de buffers',
  `pro_precio` decimal(10,2) DEFAULT NULL COMMENT 'Precio del ítem',
  `pro_costo` decimal(10,2) DEFAULT NULL COMMENT 'Costo del ítem',
  `pro_truput_total` decimal(10,2) DEFAULT NULL COMMENT 'Trúput obtenido por la venta del ítem en toda la organización en los últimos 365 días. Suma de Ventas - Suma de Costo de Ventas. Reemplaza a la tabla Trúput Anual.txt.',
  `pro_fechadescontinuado` date DEFAULT NULL COMMENT 'Fecha en la que se ha descontinuado el ítem',
  `pro_unidad` varchar(15) DEFAULT NULL COMMENT 'Unidad del sku',
  `pro_notas` text COMMENT 'Notas tel ítem',
  PRIMARY KEY (`producto_id`),
  UNIQUE KEY `NR_pro_codigo_pro_empresa_id` (`pro_codigo`,`pro_empresa_id`) USING BTREE,
  KEY `FK_familia_producto` (`pro_familia_producto_id`) USING BTREE,
  CONSTRAINT `FK_familia_producto` FOREIGN KEY (`pro_familia_producto_id`) REFERENCES `familia_producto` (`familia_producto_id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for productobodega
-- ----------------------------
DROP TABLE IF EXISTS `productobodega`;
CREATE TABLE `productobodega` (
  `productobodega_id` int(11) NOT NULL AUTO_INCREMENT,
  `producto_id` varchar(15) DEFAULT NULL,
  `bodega_id` varchar(15) DEFAULT NULL,
  PRIMARY KEY (`productobodega_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for proveedor
-- ----------------------------
DROP TABLE IF EXISTS `proveedor`;
CREATE TABLE `proveedor` (
  `proveedor_id` int(11) NOT NULL AUTO_INCREMENT,
  `pro_codigo` varchar(30) DEFAULT NULL,
  `pro_nombre` varchar(65) DEFAULT NULL,
  `pro_activa` tinyint(1) DEFAULT NULL,
  `pro_usuario` varchar(50) DEFAULT NULL,
  `pro_notas` text,
  PRIMARY KEY (`proveedor_id`),
  UNIQUE KEY `IN_pro_nombre` (`pro_nombre`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for redondeo_pedido_minimo_cab
-- ----------------------------
DROP TABLE IF EXISTS `redondeo_pedido_minimo_cab`;
CREATE TABLE `redondeo_pedido_minimo_cab` (
  `redondeo_pedido_minimo_cab_id` int(11) NOT NULL AUTO_INCREMENT,
  `rpm_nombre` varchar(50) NOT NULL,
  `rpm_campo` int(11) NOT NULL,
  PRIMARY KEY (`redondeo_pedido_minimo_cab_id`),
  UNIQUE KEY `IN_NR_Nombre` (`rpm_nombre`) USING BTREE,
  KEY `FK_Campo` (`rpm_campo`) USING BTREE,
  CONSTRAINT `FK_Campo` FOREIGN KEY (`rpm_campo`) REFERENCES `campo` (`campo_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for redondeo_pedido_minimo_det
-- ----------------------------
DROP TABLE IF EXISTS `redondeo_pedido_minimo_det`;
CREATE TABLE `redondeo_pedido_minimo_det` (
  `redondeo_pedido_minimo_det_id` int(50) NOT NULL AUTO_INCREMENT,
  `rpm_redondeo_pedido_minimo_cab_id` int(11) DEFAULT NULL,
  `rpm_categoria` varchar(50) NOT NULL,
  `rpm_porcentaje` decimal(5,2) NOT NULL,
  PRIMARY KEY (`redondeo_pedido_minimo_det_id`),
  UNIQUE KEY `IN_ND` (`rpm_redondeo_pedido_minimo_cab_id`,`rpm_categoria`) USING BTREE,
  CONSTRAINT `FK_Cabecera` FOREIGN KEY (`rpm_redondeo_pedido_minimo_cab_id`) REFERENCES `redondeo_pedido_minimo_cab` (`redondeo_pedido_minimo_cab_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for saldoinventario
-- ----------------------------
DROP TABLE IF EXISTS `saldoinventario`;
CREATE TABLE `saldoinventario` (
  `saldo_inventario_id` varchar(15) NOT NULL COMMENT 'Identificador de la Transacción',
  `sai_imp_empresa_id` varchar(15) DEFAULT NULL COMMENT 'Código de la empresa',
  `itrn_tipo` varchar(3) DEFAULT NULL COMMENT 'Si es Ingreso (ING), Egreso (EGR) o Devolución (DEV)',
  `itrn_codigo_item` varchar(15) DEFAULT NULL,
  `itrm_bodega_id_origen` varchar(15) DEFAULT NULL COMMENT 'Código de Bodega de Origen',
  `itrm_bodega_id_destino` varchar(15) DEFAULT NULL COMMENT 'Código de Bodega de Destino',
  `itrn_cantidad` decimal(10,2) DEFAULT NULL COMMENT 'Cantidad',
  PRIMARY KEY (`saldo_inventario_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for searches
-- ----------------------------
DROP TABLE IF EXISTS `searches`;
CREATE TABLE `searches` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `NAME` mediumtext,
  `USERNAME` mediumtext,
  `COOKIE` varchar(500) DEFAULT NULL,
  `SEARCH` mediumtext,
  `TABLENAME` varchar(300) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for seq_transferencia
-- ----------------------------
DROP TABLE IF EXISTS `seq_transferencia`;
CREATE TABLE `seq_transferencia` (
  `seq_transferencia_id` mediumint(9) unsigned NOT NULL AUTO_INCREMENT,
  `seqt_nombre` char(1) DEFAULT NULL,
  PRIMARY KEY (`seq_transferencia_id`)
) ENGINE=InnoDB AUTO_INCREMENT=377 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for temp
-- ----------------------------
DROP TABLE IF EXISTS `temp`;
CREATE TABLE `temp` (
  `emp_codigo` varchar(30) DEFAULT NULL COMMENT 'Código de la empresa, generalmente es propio como el RUC.',
  `bod_codigo` varchar(30) DEFAULT NULL COMMENT 'Código de la bodega que utiliza la empresa para identificarla',
  `Empresa` varchar(50) NOT NULL,
  `BODEGA` varchar(50) NOT NULL,
  `CODIGO` varchar(40) NOT NULL,
  `FECHA` datetime NOT NULL,
  `Causa` varchar(255) DEFAULT NULL,
  `BufferActual` double(10,2) DEFAULT NULL,
  `BufferNuevo` double(10,2) DEFAULT NULL,
  `Tipo` enum('Sobreinventario','Desabastecimiento','Cambio Buffer') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for tipocausa
-- ----------------------------
DROP TABLE IF EXISTS `tipocausa`;
CREATE TABLE `tipocausa` (
  `tipocausa_id` int(11) NOT NULL AUTO_INCREMENT,
  `tca_nombre` varchar(20) DEFAULT NULL,
  `tca_notas` text,
  PRIMARY KEY (`tipocausa_id`),
  UNIQUE KEY `IN_NoRepetidos` (`tca_nombre`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for tipohorizonte
-- ----------------------------
DROP TABLE IF EXISTS `tipohorizonte`;
CREATE TABLE `tipohorizonte` (
  `tipohorizonte_id` int(11) NOT NULL AUTO_INCREMENT,
  `tih_nombre` varchar(30) DEFAULT NULL,
  `tih_notas` text,
  PRIMARY KEY (`tipohorizonte_id`),
  UNIQUE KEY `IN_tih_nombre` (`tih_nombre`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for tipo_orden
-- ----------------------------
DROP TABLE IF EXISTS `tipo_orden`;
CREATE TABLE `tipo_orden` (
  `tipo_orden_id` int(11) NOT NULL AUTO_INCREMENT,
  `tor_tipo_general` varchar(20) DEFAULT NULL,
  `tor_tipo_especifico` varchar(20) DEFAULT NULL,
  `tor_notas` text,
  PRIMARY KEY (`tipo_orden_id`),
  UNIQUE KEY `IN_NoRepetido` (`tor_tipo_general`,`tor_tipo_especifico`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for tmp_v_usuario_clave
-- ----------------------------
DROP TABLE IF EXISTS `tmp_v_usuario_clave`;
CREATE TABLE `tmp_v_usuario_clave` (
  `USUARIO` varchar(30) DEFAULT NULL COMMENT 'Nombre del usuario',
  `CLAVE` varchar(41) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `ENCRIPTADA` varchar(100) DEFAULT NULL COMMENT 'Clave del usuario'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for transferbd
-- ----------------------------
DROP TABLE IF EXISTS `transferbd`;
CREATE TABLE `transferbd` (
  `EMPRESA` varchar(30) NOT NULL DEFAULT '',
  `Codtrans` varchar(10) NOT NULL DEFAULT '',
  `FechaOrigen` date NOT NULL,
  `FechaCierre` date NOT NULL,
  `Origen` varchar(40) DEFAULT '',
  `Destino` varchar(40) DEFAULT '',
  `Referencia` varchar(50) DEFAULT '',
  `CODIGO` varchar(40) DEFAULT '',
  `DESCRIPCION` varchar(255) DEFAULT '',
  `GRUPO` varchar(100) DEFAULT '',
  `LINEA` varchar(100) DEFAULT '',
  `PedProm` double(8,2) DEFAULT '0.00',
  `CTV` decimal(8,2) DEFAULT '0.00',
  `PV` decimal(8,2) DEFAULT '0.00',
  `BUFFER` double(8,2) DEFAULT '0.00',
  `CONSBUFF` double(8,2) DEFAULT '0.00',
  `RENTABILIDAD` double(15,5) DEFAULT '0.00000',
  `VELEFECT` double(8,2) DEFAULT '0.00',
  `SERVICIO` double(8,2) DEFAULT '0.00',
  `REQUERIM` double(8,2) DEFAULT '0.00',
  `REQTOTAL` double(8,2) DEFAULT '0.00',
  `DESPACHO` double(8,2) DEFAULT '0.00',
  `RECIBIDO` double(8,2) DEFAULT '0.00',
  `TRANSITO` double(8,2) DEFAULT '0.00',
  `OBSERVACIONESDESPACHOS` varchar(255) DEFAULT '',
  `OBSERVACIONESRECEPCIONES` varchar(255) DEFAULT '',
  `TIPOTRANSF` varchar(1) DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for transferencia_cabecera
-- ----------------------------
DROP TABLE IF EXISTS `transferencia_cabecera`;
CREATE TABLE `transferencia_cabecera` (
  `transferencia_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `tra_codigo` int(11) unsigned DEFAULT NULL,
  `tra_codigo_referencial` varchar(50) DEFAULT NULL,
  `tra_fecha_creacion` date DEFAULT NULL,
  `tra_fecha_cierre` date DEFAULT NULL,
  `tra_fecha_arribo` date DEFAULT NULL,
  `tra_empresa_id` varchar(50) DEFAULT NULL,
  `tra_origen_id` varchar(50) DEFAULT NULL,
  `tra_destino_id` varchar(50) DEFAULT NULL,
  `tra_referencia` varchar(100) DEFAULT NULL,
  `tra_estado` enum('INA','ACT') DEFAULT NULL,
  `tra_nombre_archivo` varchar(100) DEFAULT NULL,
  `tra_dueno` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`transferencia_id`),
  UNIQUE KEY `ND_codigo` (`tra_codigo`) USING BTREE,
  KEY `ND_estado` (`tra_estado`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1111 DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for transferencia_detalle
-- ----------------------------
DROP TABLE IF EXISTS `transferencia_detalle`;
CREATE TABLE `transferencia_detalle` (
  `transferencia_detalle_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `tdet_transferencia_id` int(11) unsigned DEFAULT NULL,
  `tdet_transferencia_codigo` int(11) unsigned DEFAULT NULL,
  `tdet_transferencia_codigo_po` varchar(50) DEFAULT NULL,
  `tdet_codigo` varchar(50) DEFAULT NULL,
  `tdet_cantidad_sugerida` decimal(8,2) DEFAULT NULL,
  `tdet_cantidad_real` decimal(8,2) DEFAULT NULL,
  `tdet_transito` decimal(8,2) DEFAULT NULL,
  `tdet_embarque_uno` int(11) DEFAULT NULL,
  `tdet_embarque_dos` int(11) DEFAULT NULL,
  `tdet_embarque_tres` int(11) DEFAULT NULL,
  `tdet_embarque_cuatro` int(11) DEFAULT NULL,
  `tdet_embarque_cinco` int(11) DEFAULT NULL,
  `tdet_estado` enum('ACT','INA') DEFAULT NULL,
  `tdet_fecha_de` date DEFAULT NULL,
  `tdet_fecha_hasta` date DEFAULT NULL,
  PRIMARY KEY (`transferencia_detalle_id`),
  KEY `FK_Codigo` (`tdet_transferencia_id`) USING BTREE,
  KEY `ND_estado` (`tdet_estado`) USING BTREE,
  CONSTRAINT `FK_Codigo` FOREIGN KEY (`tdet_transferencia_id`) REFERENCES `transferencia_cabecera` (`transferencia_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=166287 DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for usuario
-- ----------------------------
DROP TABLE IF EXISTS `usuario`;
CREATE TABLE `usuario` (
  `usuario_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Identificador único del usuario.',
  `usu_nombre` varchar(30) DEFAULT NULL COMMENT 'Nombre del usuario',
  `usu_clave` varchar(100) DEFAULT NULL COMMENT 'Clave del usuario',
  `usu_nombre_completo` varchar(50) DEFAULT NULL,
  `usu_email` varchar(80) DEFAULT NULL,
  `usu_grupo` varchar(80) DEFAULT NULL,
  `active` int(11) DEFAULT NULL,
  PRIMARY KEY (`usuario_id`),
  UNIQUE KEY `IN_usu_nombre` (`usu_nombre`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for usuario_archivo
-- ----------------------------
DROP TABLE IF EXISTS `usuario_archivo`;
CREATE TABLE `usuario_archivo` (
  `usuario_archivo_id` int(11) NOT NULL AUTO_INCREMENT,
  `ua_usuario_id` int(11) DEFAULT NULL,
  `ua_archivo_id` int(11) DEFAULT NULL,
  `ua_activa` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`usuario_archivo_id`),
  UNIQUE KEY `NR_usuario_archivo` (`ua_usuario_id`,`ua_archivo_id`) USING BTREE,
  KEY `FK_ua_archivo_id` (`ua_archivo_id`) USING BTREE,
  CONSTRAINT `FK_ua_archivo_id` FOREIGN KEY (`ua_archivo_id`) REFERENCES `archivo` (`archivo_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_ua_usuario_id` FOREIGN KEY (`ua_usuario_id`) REFERENCES `usuario` (`usuario_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=128 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for usuario_bodega
-- ----------------------------
DROP TABLE IF EXISTS `usuario_bodega`;
CREATE TABLE `usuario_bodega` (
  `usuario_bodega_id` int(11) NOT NULL AUTO_INCREMENT,
  `ub_usuario_id` int(11) DEFAULT NULL,
  `ub_bodega_id` int(11) DEFAULT NULL,
  `ub_activa` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`usuario_bodega_id`),
  UNIQUE KEY `NR_usuario_bodega` (`ub_usuario_id`,`ub_bodega_id`) USING BTREE,
  KEY `FK_ub_bodega_id` (`ub_bodega_id`) USING BTREE,
  CONSTRAINT `FK_ub_bodega_id` FOREIGN KEY (`ub_bodega_id`) REFERENCES `bodega` (`bodega_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_ub_usuario_id` FOREIGN KEY (`ub_usuario_id`) REFERENCES `usuario` (`usuario_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=84 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for usuario_empresa
-- ----------------------------
DROP TABLE IF EXISTS `usuario_empresa`;
CREATE TABLE `usuario_empresa` (
  `usuario_empresa_id` int(11) NOT NULL AUTO_INCREMENT,
  `ue_usuario_id` int(11) DEFAULT NULL,
  `ue_empresa_id` int(11) DEFAULT NULL,
  `ue_activa` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`usuario_empresa_id`),
  UNIQUE KEY `NR_usuario_empresa` (`ue_usuario_id`,`ue_empresa_id`) USING BTREE,
  KEY `FK_ue_empresa_id` (`ue_empresa_id`) USING BTREE,
  CONSTRAINT `FK_ue_empresa_id` FOREIGN KEY (`ue_empresa_id`) REFERENCES `empresa` (`empresa_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_ue_usuario_id` FOREIGN KEY (`ue_usuario_id`) REFERENCES `usuario` (`usuario_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for variabilities
-- ----------------------------
DROP TABLE IF EXISTS `variabilities`;
CREATE TABLE `variabilities` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name_spanish` varchar(10) NOT NULL,
  `name_english` varchar(10) NOT NULL,
  `type_spanish` enum('Reposición','Demanda') NOT NULL,
  `type_english` enum('Supply','Demand') NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UN_name_spanish` (`name_spanish`,`type_spanish`) USING BTREE,
  UNIQUE KEY `UN_name_english` (`name_english`,`type_english`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for vista
-- ----------------------------
DROP TABLE IF EXISTS `vista`;
CREATE TABLE `vista` (
  `vista_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Identificador único de la vista',
  `vis_nombre` varchar(70) DEFAULT NULL COMMENT 'Nombre de la vista',
  `vis_tipo` enum('Transferencias','Hojas CB') DEFAULT NULL,
  `vis_notas` text COMMENT 'Notas de la vista',
  PRIMARY KEY (`vista_id`),
  UNIQUE KEY `NR_vis_nombre_vis_tipo` (`vis_nombre`,`vis_tipo`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for vistacampo
-- ----------------------------
DROP TABLE IF EXISTS `vistacampo`;
CREATE TABLE `vistacampo` (
  `vistacampo_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Identificador único de la relación entre campo y vista',
  `vsc_vista_id` int(11) DEFAULT NULL COMMENT 'FK del identificador de vista',
  `vsc_campo_id` int(11) DEFAULT NULL COMMENT 'FK del identificador de campo',
  `vsc_activa` tinyint(1) DEFAULT NULL COMMENT 'Define si el campo está activo en la vista actual.',
  PRIMARY KEY (`vistacampo_id`),
  UNIQUE KEY `Unique` (`vsc_vista_id`,`vsc_campo_id`) USING BTREE,
  KEY `FK_vsc_campo_id` (`vsc_campo_id`),
  CONSTRAINT `FK_vsc_campo_id` FOREIGN KEY (`vsc_campo_id`) REFERENCES `campo` (`campo_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_vsc_vista_id` FOREIGN KEY (`vsc_vista_id`) REFERENCES `vista` (`vista_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1396 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for webreports
-- ----------------------------
DROP TABLE IF EXISTS `webreports`;
CREATE TABLE `webreports` (
  `rpt_id` int(11) NOT NULL AUTO_INCREMENT,
  `rpt_name` varchar(100) NOT NULL,
  `rpt_title` varchar(200) DEFAULT NULL,
  `rpt_cdate` datetime NOT NULL,
  `rpt_mdate` datetime DEFAULT NULL,
  `rpt_content` mediumtext NOT NULL,
  `rpt_owner` varchar(100) NOT NULL,
  `rpt_status` varchar(10) NOT NULL DEFAULT 'public',
  `rpt_type` varchar(10) NOT NULL,
  PRIMARY KEY (`rpt_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for webreport_admin
-- ----------------------------
DROP TABLE IF EXISTS `webreport_admin`;
CREATE TABLE `webreport_admin` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tablename` varchar(250) DEFAULT NULL,
  `db_type` varchar(10) DEFAULT NULL,
  `group_name` varchar(250) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for webreport_sql
-- ----------------------------
DROP TABLE IF EXISTS `webreport_sql`;
CREATE TABLE `webreport_sql` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sqlname` varchar(100) DEFAULT NULL,
  `sqlcontent` mediumtext,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for webreport_style
-- ----------------------------
DROP TABLE IF EXISTS `webreport_style`;
CREATE TABLE `webreport_style` (
  `report_style_id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(6) NOT NULL,
  `field` int(11) NOT NULL,
  `group` int(11) NOT NULL,
  `style_str` mediumtext NOT NULL,
  `uniq` int(11) DEFAULT NULL,
  `repname` varchar(255) NOT NULL,
  `styletype` varchar(40) NOT NULL,
  PRIMARY KEY (`report_style_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- View structure for temporal_trep_frep
-- ----------------------------
DROP VIEW IF EXISTS `temporal_trep_frep`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY INVOKER  VIEW `temporal_trep_frep` AS SELECT
b.bod_nombre AS BODEGA,
dc.con_codigo AS CODIGO,
ip.pro_descripcion AS DESCRIPCION,
dc.con_codigo_generico AS `COD GENERICO`,
dc.con_codigo_vinculado AS `COD VINCULADO`,
dc.con_ctv AS CTV,
dc.con_pv AS PV,
dc.con_buffer,
dc.con_inventario_fisico,
perfilreposicion.pre_frecuenciareposicion AS frep,
perfilreposicion.pre_tiemposuministro AS trep
FROM
datos_consolidados AS dc
INNER JOIN bodega AS b ON b.bodega_id = dc.con_bodega
INNER JOIN imp_producto AS ip ON ip.pro_codigo = dc.con_codigo
INNER JOIN perfilreposicion ON perfilreposicion.perfilreposicion_id = dc.con_perfil
WHERE b.bod_nombre = 'GYE.Bodega Central'
ORDER BY
CODIGO ASC ;

-- ----------------------------
-- View structure for vhistorialtransferencias
-- ----------------------------
DROP VIEW IF EXISTS `vhistorialtransferencias`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER  VIEW `vhistorialtransferencias` AS select `transferbd`.`EMPRESA` AS `EMPRESA`,`transferbd`.`Codtrans` AS `Codtrans`,`transferbd`.`FechaOrigen` AS `FechaOrigen`,`transferbd`.`FechaCierre` AS `FechaCierre`,`transferbd`.`Origen` AS `Origen`,`transferbd`.`Destino` AS `Destino`,`transferbd`.`Referencia` AS `Referencia`,`transferbd`.`CODIGO` AS `CODIGO`,`transferbd`.`DESCRIPCION` AS `DESCRIPCION`,`transferbd`.`GRUPO` AS `GRUPO`,`transferbd`.`LINEA` AS `LINEA`,`transferbd`.`PedProm` AS `Ped Prom`,`transferbd`.`CTV` AS `CTV`,`transferbd`.`PV` AS `PV`,`transferbd`.`BUFFER` AS `BUFFER`,`transferbd`.`CONSBUFF` AS `CONS BUFF`,`transferbd`.`RENTABILIDAD` AS `RENTABILIDAD`,`transferbd`.`REQUERIM` AS `REQUERIM`,`transferbd`.`REQTOTAL` AS `REQ TOTAL`,`transferbd`.`DESPACHO` AS `DESPACHO`,`transferbd`.`RECIBIDO` AS `RECIBIDO`,`transferbd`.`TRANSITO` AS `TRANSITO`,`transferbd`.`OBSERVACIONESDESPACHOS` AS `OBSERVACIONES DESPACHOS`,`transferbd`.`OBSERVACIONESRECEPCIONES` AS `OBSERVACIONES RECEPCIONES`,`transferbd`.`TIPOTRANSF` AS `TIPO TRANSF` from `transferbd` order by `transferbd`.`Codtrans`,`transferbd`.`CODIGO` ;

-- ----------------------------
-- View structure for v_auditoria_datos_erp
-- ----------------------------
DROP VIEW IF EXISTS `v_auditoria_datos_erp`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER  VIEW `v_auditoria_datos_erp` AS SELECT
	e.emp_nombre AS 'EMPRESA',
	ib.bod_nombre AS 'BODEGA_ERP',
	b.bod_nombre AS 'BODEGA BUFFER',
	ii.inv_producto_id AS 'CODIGO',
	ip.pro_codigovinculado AS 'CODIGO VINCULADO',
	ip.pro_descripcion AS 'DESCRIPCION',
	ii.inv_existencia AS 'EXISTENCIA',
	ii.inv_transito AS 'TRANSITO',
	ii.inv_comprometido AS 'COMPROMETIDO',
	ii.inv_backorder AS 'BACKORDER'
FROM
	imp_inventario ii
LEFT JOIN empresa e ON ii.inv_empresa_id = e.emp_codigo
LEFT JOIN imp_bodega ib ON ib.bod_codigo = ii.inv_bodega_id
LEFT JOIN imp_producto ip ON ip.pro_empresa_id = e.emp_codigo AND ip.pro_codigo = ii.inv_producto_id
LEFT JOIN bodega b ON b.bod_empresa_id = e.emp_codigo AND b.bod_codigo = ii.inv_bodega_id
-- WHERE ii.inv_existencia >0 OR ii.inv_transito > 0 OR ii.inv_comprometido >0 OR ii.inv_backorder > 0
ORDER BY e.emp_nombre DESC ;

-- ----------------------------
-- View structure for v_bodega_amarillo
-- ----------------------------
DROP VIEW IF EXISTS `v_bodega_amarillo`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER  VIEW `v_bodega_amarillo` AS SELECT
	dc.con_bodega,
	count(dc.con_color) AS 'Amarillo'
FROM
	datos_consolidados dc
WHERE
	dc.con_color = 'A'
GROUP BY
	dc.con_bodega ;

-- ----------------------------
-- View structure for v_bodega_gris
-- ----------------------------
DROP VIEW IF EXISTS `v_bodega_gris`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER  VIEW `v_bodega_gris` AS SELECT
	dc.con_bodega,
	count(dc.con_color) AS 'Gris'
FROM
	datos_consolidados dc
WHERE
	dc.con_color = 'G'
GROUP BY
	dc.con_bodega ;

-- ----------------------------
-- View structure for v_bodega_item_consolidado
-- ----------------------------
DROP VIEW IF EXISTS `v_bodega_item_consolidado`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER  VIEW `v_bodega_item_consolidado` AS SELECT
concat(
		bodega.bod_codigo,
		datos_consolidados.con_codigo
	) AS bodega_producto,
bodega.bod_codigo AS bodega,
datos_consolidados.con_codigo AS producto
FROM
bodega
INNER JOIN datos_consolidados ON bodega.bodega_id = datos_consolidados.con_bodega
ORDER BY
	bodega.bod_codigo,
	datos_consolidados.con_codigo ;

-- ----------------------------
-- View structure for v_bodega_item_consolidado_activos
-- ----------------------------
DROP VIEW IF EXISTS `v_bodega_item_consolidado_activos`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER  VIEW `v_bodega_item_consolidado_activos` AS SELECT
CONCAT(b.bod_codigo,c.con_codigo) AS bodega_producto,
b.bod_codigo AS bodega,
c.con_codigo AS producto
FROM
datos_consolidados AS c
LEFT JOIN v_productos_dados_de_baja AS v ON c.con_codigo = v.con_codigo
INNER JOIN bodega AS b ON b.bodega_id = c.con_bodega 
WHERE
v.con_codigo IS NULL 
ORDER BY
b.bod_codigo, c.con_codigo ;

-- ----------------------------
-- View structure for v_bodega_item_faltante
-- ----------------------------
DROP VIEW IF EXISTS `v_bodega_item_faltante`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER  VIEW `v_bodega_item_faltante` AS SELECT
trim(b.bod_nombre) AS 'BODEGA',
trim(t.producto) AS 'PRODUCTO'
FROM
v_bodega_item_total t
LEFT JOIN v_bodega_item_consolidado_activos a ON t.bodega_producto = a.bodega_producto INNER JOIN bodega b ON b.bod_codigo = t.bodega
WHERE
a.producto IS NULL
ORDER BY
trim(b.bod_nombre), trim(t.producto) ;

-- ----------------------------
-- View structure for v_bodega_item_total
-- ----------------------------
DROP VIEW IF EXISTS `v_bodega_item_total`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER  VIEW `v_bodega_item_total` AS SELECT
	concat(
		bodega.bod_codigo,
		imp_producto.pro_codigo
	) AS 'bodega_producto',
	bodega.bod_codigo AS 'bodega',
	imp_producto.pro_codigo AS 'producto'
FROM
	imp_producto,
	bodega
ORDER BY
	bodega.bod_codigo,
	imp_producto.pro_codigo ;

-- ----------------------------
-- View structure for v_bodega_lila
-- ----------------------------
DROP VIEW IF EXISTS `v_bodega_lila`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER  VIEW `v_bodega_lila` AS SELECT
	dc.con_bodega,
	count(dc.con_color) AS 'Lila'
FROM
	datos_consolidados dc
WHERE
	dc.con_color = 'L'
GROUP BY
	dc.con_bodega ;

-- ----------------------------
-- View structure for v_bodega_negro
-- ----------------------------
DROP VIEW IF EXISTS `v_bodega_negro`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER  VIEW `v_bodega_negro` AS SELECT
	dc.con_bodega,
	count(dc.con_color) AS 'Negro'
FROM
	datos_consolidados dc
WHERE
	dc.con_color = 'N'
GROUP BY
	dc.con_bodega ;

-- ----------------------------
-- View structure for v_bodega_rojo
-- ----------------------------
DROP VIEW IF EXISTS `v_bodega_rojo`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER  VIEW `v_bodega_rojo` AS SELECT
	dc.con_bodega,
	count(dc.con_color) AS 'Rojo'
FROM
	datos_consolidados dc
WHERE
	dc.con_color = 'R'
GROUP BY
	dc.con_bodega ;

-- ----------------------------
-- View structure for v_bodega_verde
-- ----------------------------
DROP VIEW IF EXISTS `v_bodega_verde`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER  VIEW `v_bodega_verde` AS SELECT
	dc.con_bodega,
	count(dc.con_color) AS 'Verde'
FROM
	datos_consolidados dc
WHERE
	dc.con_color = 'V'
GROUP BY
	dc.con_bodega ;

-- ----------------------------
-- View structure for v_buffers_por_color
-- ----------------------------
DROP VIEW IF EXISTS `v_buffers_por_color`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER  VIEW `v_buffers_por_color` AS SELECT
	histinventarios.EMPRESA AS 'EMPRESA',
	histinventarios.BODEGA AS 'BODEGA',
	histinventarios.Color AS 'COLOR'	
FROM
	histinventarios

WHERE
	(
			`histinventarios`.`FECHA` = (
				SELECT
					max(`histinventarios`.`FECHA`) AS `max(HISTINVENTARIOS.FECHA)`
				FROM
					`histinventarios`
			)
		)
ORDER BY
	histinventarios.EMPRESA,
	histinventarios.BODEGA ;

-- ----------------------------
-- View structure for v_buffers_valorados
-- ----------------------------
DROP VIEW IF EXISTS `v_buffers_valorados`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER  VIEW `v_buffers_valorados` AS SELECT DISTINCT
	bh.emp_nombre AS EMPRESA,
	bh.bod_nombre AS BODEGA,
	bh.buh_codigo AS CODIGO,
	ip.pro_descripcion AS DESCRIPCION,
	ip.pro_grupo AS GRUPO,
	ip.pro_linea AS LINEA,
	ip.pro_sublinea AS SUBLINEA,
	ip.pro_modelo AS MODELO,
	ip.pro_familia AS FAMILIA,
	ip.pro_subfamilia AS SUBFAMILIA,
	ip.pro_categoria AS CATEGORIA,
	ip.pro_tipo AS TIPO,
	ip.pro_marca AS MARCA,
	bh.buh_buffer_actual AS BUFFER,
	if(bh.buh_nuevo_buffer_sugerido is not null, bh.buh_nuevo_buffer_sugerido, bh.buh_buffer_actual) AS 'BUFFER SUG',
	bh.buh_inventario_fisico AS FISICO,
	bh.buh_transito AS 	TRANSITO,
	round(bh.buh_ctv, 2) AS CTV,
	ROUND(
				bh.buh_buffer_actual * bh.buh_ctv		,
		2
	) AS 'COSTO BUFFER', 
round(if(bh.buh_nuevo_buffer_sugerido is not null, bh.buh_nuevo_buffer_sugerido, bh.buh_buffer_actual)*bh.buh_ctv,2) AS 'COSTO BUFF SUG',
round(bh.buh_inventario_fisico*bh.buh_ctv, 2) AS 'COSTO FISICO', ROUND(bh.buh_transito*bh.buh_ctv) AS 'COSTO TRANSITO',
(round(bh.buh_inventario_fisico*bh.buh_ctv, 2) + ROUND(bh.buh_transito*bh.buh_ctv)) AS 'FISICO + TRANSITO'
FROM
	v_buffer_hist_hoy bh
INNER JOIN imp_producto ip ON ip.pro_codigo = bh.buh_codigo
ORDER BY bh.emp_nombre, bh.bod_nombre, ROUND(bh.buh_buffer_actual * bh.buh_ctv, 2) desc ;

-- ----------------------------
-- View structure for v_buffer_hist_grafico_dinamico
-- ----------------------------
DROP VIEW IF EXISTS `v_buffer_hist_grafico_dinamico`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER  VIEW `v_buffer_hist_grafico_dinamico` AS SELECT
	bh.buh_empresa AS 'EMPRESA_CODIGO',
	e.emp_nombre AS 'EMPRESA_NOMBRE',
	bh.buh_bodega AS 'BODEGA_CODIGO',
	b.bod_nombre AS 'BODEGA_NOMBRE',
	bh.buh_codigo AS 'CODIGO',
	bh.buh_codigo_vinculado AS 'CODIGO_VINCULADO',
	bh.buh_codigo_generico AS 'CODIGO_GENERICO',
	convert(bh.buh_fecha, Date) AS 'FECHA',
	bh.buh_buffer_actual AS 'BUFFER',
	bh.buh_zona_amarilla AS 'ZONA_AMARILLA',
	bh.buh_zona_roja AS 'ZONA_ROJA',
	bh.buh_inventario_fisico AS 'INVENTARIO_FISICO',
	bh.buh_inventario_proyectado AS 'INVENTARIO_PROYECTADO'
FROM
	buffer_hist bh
INNER JOIN bodega b ON bh.buh_bodega = b.bod_codigo
INNER JOIN empresa e ON b.bod_empresa_id = e.empresa_id
AND bh.buh_empresa = e.emp_codigo
AND bh.buh_fecha > DATE_SUB(curdate(), INTERVAL 365 DAY)
ORDER BY
	bh.buh_empresa,
	bh.buh_bodega,
	bh.buh_codigo,
	bh.buh_fecha ;

-- ----------------------------
-- View structure for v_buffer_hist_grafico_dinamico_con_causas
-- ----------------------------
DROP VIEW IF EXISTS `v_buffer_hist_grafico_dinamico_con_causas`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER  VIEW `v_buffer_hist_grafico_dinamico_con_causas` AS SELECT
	g.EMPRESA_CODIGO,
	g.EMPRESA_NOMBRE,
	g.BODEGA_CODIGO,
	g.BODEGA_NOMBRE,
	g.CODIGO,
	g.CODIGO_VINCULADO,
	g.CODIGO_GENERICO,
	g.FECHA,
	g.BUFFER,
	g.ZONA_AMARILLA,
	g.ZONA_ROJA,
	g.INVENTARIO_FISICO,
	g.INVENTARIO_PROYECTADO,
	hc.hc_causa AS CAUSA
FROM
	v_buffer_hist_grafico_dinamico AS g
LEFT JOIN historial_causas AS hc ON g.EMPRESA_CODIGO = hc.hc_empresa_codigo
AND g.BODEGA_CODIGO = hc.hc_bodega_codigo
AND g.FECHA = date(hc.hc_fecha)
AND g.CODIGO = hc.hc_codigo ;

-- ----------------------------
-- View structure for v_buffer_hist_hoy
-- ----------------------------
DROP VIEW IF EXISTS `v_buffer_hist_hoy`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER  VIEW `v_buffer_hist_hoy` AS SELECT
	bh.buh_empresa,
	bh.buh_archivo,
	bh.buh_fecha,
	bh.buh_bodega,
	bh.buh_codigo,
	bh.buh_codigo_funcional,
	bh.buh_codigo_vinculado,
	bh.buh_codigo_generico,
	bh.buh_estatus,
	bh.buh_clasificacion,
	bh.buh_responsable,
	bh.buh_ctv,
	bh.buh_pv,
	bh.buh_precio_promocion,
	bh.buh_promocion_desde,
	bh.buh_promocion_hasta,
	bh.buh_proveedor,
	bh.buh_perfil,
	bh.buh_horizonte,
	bh.buh_tiempo_suministro,
	bh.buh_frecuencia_reposicion,
	bh.buh_gdb,
	bh.buh_cam,
	bh.buh_etapa,
	bh.buh_nuevo_buffer_sugerido,
	bh.buh_comportamiento,
	bh.buh_consumo,
	bh.buh_buffer_calculado,
	bh.buh_cobertura_buffer,
	bh.buh_cobertura_inventario_proyectado,
	bh.buh_cobertura_pedido_minimo,
	bh.buh_dias_desabastecimiento,
	bh.buh_ventas_perdidas,
	bh.buh_observaciones,
	bh.buh_nuevo_buffer_real,
	bh.buh_posponer_alerta_buf,
	bh.buh_posponer_alerta_red,
	bh.buh_posponer_alerta_gdb,
	bh.buh_buffer_minimo,
	bh.buh_buffer_maximo,
	bh.buh_pedido_minimo,
	bh.buh_redondeo_pedido_minimo,
	bh.buh_pedido_minimo_grupo,
	bh.buh_unidad_empaque,
	bh.buh_redondeo_unidad_empaque,
	bh.buh_porcentaje_atencion,
	bh.buh_impacto_faltante,
	bh.buh_buffer_actual,
	bh.buh_zona_amarilla,
	bh.buh_zona_roja,
	bh.buh_color_inventario_fisico,
	bh.buh_color_inventario_proyectado,
	bh.buh_ultimo_buffer,
	bh.buh_buffer_anterior_estacion,
	bh.buh_buffer_estacional,
	bh.buh_inventario_proveedor,
	bh.buh_inventario_fisico,
	bh.buh_estado_inventario_fisico,
	bh.buh_transito,
	bh.buh_negociacion,
	bh.buh_produccion,
	bh.buh_embarcado,
	bh.buh_comprometido,
	bh.buh_backorder,
	bh.buh_inventario_proyectado,
	bh.buh_estado_inventario_proyectado,
	bh.buh_ingresos,
	bh.buh_egresos,
	bh.buh_pedido_calculado_auxiliar,
	bh.buh_pedido_calculado,
	bh.buh_pedido_promedio,
	bh.buh_pedido_real,
	bh.buh_calendario_estacional,
	bh.buh_accion_estacional,
	bh.buh_etapa_estacional,
	bh.buh_tdd,
	bh.buh_idd,
	bh.buh_roi_pasado,
	bh.buh_roi_proyectado,
	bh.buh_velocity,
	bh.buh_nivel_servicio,
	bh.buh_ultimo_cambio,
	bh.buh_nuevo_inicio_horizonte,
	bh.buh_inicio_horizonte,
	bh.buh_fin_horizonte,
	bh.buh_ultima_transferencia_ini,
	bh.buh_ultima_transferencia_fin,
	bh.buh_variabilidad,
	bh.buh_rojo_acumulado,
	bh.buh_negro,
	bh.buh_rojo,
	bh.buh_amarillo,
	bh.buh_verde,
	bh.buh_lila,
	e.emp_nombre,
	b.bod_nombre,
	a.ach_nombre,
	p.pro_nombre,
	pr.pre_nombre,
	ip.pro_descripcion,
	ip.pro_grupo,
	ip.pro_linea,
	ip.pro_sublinea,
	ip.pro_modelo,
	ip.pro_familia,
	ip.pro_subfamilia,
	ip.pro_categoria,
	ip.pro_tipo,
	ip.pro_marca,
	ip.pro_cat_management,
	bh.buh_estado_reposiciones,
	bh.buh_fecha_nuevo_pedido,
	bh.buh_fecha_esperada_arribo
FROM
	buffer_hoy AS bh
LEFT JOIN empresa e ON e.emp_codigo = bh.buh_empresa
LEFT JOIN bodega b ON b.bod_empresa_id = e.empresa_id
AND bh.buh_bodega = b.bod_codigo
LEFT JOIN archivo a ON a.ach_empresa_id = e.empresa_id
AND bh.buh_archivo = a.archivo_id
LEFT JOIN imp_producto ip ON bh.buh_empresa = ip.pro_empresa_id
AND bh.buh_codigo = ip.pro_codigo
LEFT JOIN proveedor p ON p.proveedor_id = bh.buh_proveedor
LEFT JOIN perfilreposicion pr ON bh.buh_perfil = pr.perfilreposicion_id
ORDER BY
	e.emp_nombre,
	b.bod_nombre,
	bh.buh_codigo ;

-- ----------------------------
-- View structure for v_buffer_hist_limitado
-- ----------------------------
DROP VIEW IF EXISTS `v_buffer_hist_limitado`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER  VIEW `v_buffer_hist_limitado` AS SELECT
	bh.buh_empresa,
	bh.buh_archivo,
	bh.buh_fecha,
	bh.buh_bodega,
	bh.buh_codigo,
	bh.buh_codigo_funcional,
	bh.buh_codigo_vinculado,
	bh.buh_codigo_generico,
	bh.buh_estatus,
	bh.buh_clasificacion,
	bh.buh_responsable,
	bh.buh_ctv,
	bh.buh_pv,
	bh.buh_precio_promocion,
	bh.buh_promocion_desde,
	bh.buh_promocion_hasta,
	bh.buh_proveedor,
	bh.buh_perfil,
	bh.buh_horizonte,
	bh.buh_tiempo_suministro,
	bh.buh_frecuencia_reposicion,
	bh.buh_gdb,
	bh.buh_cam,
	bh.buh_etapa,
	bh.buh_nuevo_buffer_sugerido,
	bh.buh_comportamiento,
	bh.buh_consumo,
	bh.buh_buffer_calculado,
	bh.buh_cobertura_buffer,
	bh.buh_cobertura_inventario_proyectado,
	bh.buh_cobertura_pedido_minimo,
	bh.buh_dias_desabastecimiento,
	bh.buh_ventas_perdidas,
	bh.buh_observaciones,
	bh.buh_nuevo_buffer_real,
	bh.buh_posponer_alerta_buf,
	bh.buh_posponer_alerta_red,
	bh.buh_posponer_alerta_gdb,
	bh.buh_buffer_minimo,
	bh.buh_buffer_maximo,
	bh.buh_pedido_minimo,
	bh.buh_redondeo_pedido_minimo,
	bh.buh_pedido_minimo_grupo,
	bh.buh_unidad_empaque,
	bh.buh_redondeo_unidad_empaque,
	bh.buh_porcentaje_atencion,
	bh.buh_impacto_faltante,
	bh.buh_buffer_actual,
	bh.buh_zona_amarilla,
	bh.buh_zona_roja,
	bh.buh_color_inventario_fisico,
	bh.buh_color_inventario_proyectado,
	bh.buh_ultimo_buffer,
	bh.buh_buffer_anterior_estacion,
	bh.buh_buffer_estacional,
	bh.buh_inventario_proveedor,
	bh.buh_inventario_fisico,
	bh.buh_estado_inventario_fisico,
	bh.buh_transito,
	bh.buh_negociacion,
	bh.buh_produccion,
	bh.buh_embarcado,
	bh.buh_comprometido,
	bh.buh_backorder,
	bh.buh_inventario_proyectado,
	bh.buh_estado_inventario_proyectado,
	bh.buh_ingresos,
	bh.buh_egresos,
	bh.buh_pedido_calculado_auxiliar,
	bh.buh_pedido_calculado,
	bh.buh_pedido_promedio,
	bh.buh_pedido_real,
	bh.buh_calendario_estacional,
	bh.buh_accion_estacional,
	bh.buh_etapa_estacional,
	bh.buh_tdd,
	bh.buh_idd,
	bh.buh_roi_pasado,
	bh.buh_roi_proyectado,
	bh.buh_velocity,
	bh.buh_nivel_servicio,
	bh.buh_ultimo_cambio,
	bh.buh_nuevo_inicio_horizonte,
	bh.buh_inicio_horizonte,
	bh.buh_fin_horizonte,
	bh.buh_ultima_transferencia_ini,
	bh.buh_ultima_transferencia_fin,
	bh.buh_variabilidad,
	bh.buh_rojo_acumulado,
	bh.buh_negro,
	bh.buh_rojo,
	bh.buh_amarillo,
	bh.buh_verde,
	bh.buh_lila,
	e.emp_nombre,
	b.bod_nombre,
	a.ach_nombre,
	p.pro_nombre,
	pr.pre_nombre,
	ip.pro_descripcion,
	ip.pro_grupo,
	ip.pro_linea,
	ip.pro_sublinea,
	ip.pro_modelo,
	ip.pro_familia,
	ip.pro_subfamilia,
	ip.pro_categoria,
	ip.pro_tipo,
	ip.pro_marca,
	ip.pro_cat_management,
	bh.buh_estado_reposiciones,
	bh.buh_fecha_nuevo_pedido,
	bh.buh_fecha_esperada_arribo
FROM
	buffer_hist_cortado AS bh
LEFT JOIN empresa e ON e.emp_codigo = bh.buh_empresa
LEFT JOIN bodega b ON b.bod_empresa_id = e.empresa_id
AND bh.buh_bodega = b.bod_codigo
LEFT JOIN archivo a ON a.ach_empresa_id = e.empresa_id
AND bh.buh_archivo = a.archivo_id
LEFT JOIN imp_producto ip ON bh.buh_empresa = ip.pro_empresa_id
AND bh.buh_codigo = ip.pro_codigo
LEFT JOIN proveedor p ON p.proveedor_id = bh.buh_proveedor
LEFT JOIN perfilreposicion pr ON bh.buh_perfil = pr.perfilreposicion_id
-- WHERE bh.buh_fecha >= DATE_SUB(CURDATE(),INTERVAL 6 MONTH)
ORDER BY
	e.emp_nombre,
	b.bod_nombre,
	bh.buh_codigo ;

-- ----------------------------
-- View structure for v_buffer_ideal_evolucion
-- ----------------------------
DROP VIEW IF EXISTS `v_buffer_ideal_evolucion`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER  VIEW `v_buffer_ideal_evolucion` AS SELECT
	e.emp_nombre AS 'EMPRESA',
	bh.buh_clasificacion AS 'CLASIFICACION',
	bh.buh_responsable AS 'RESPONSABLE',
	SUM(
		bh.buh_buffer_actual * bh.buh_ctv
	) AS 'COSTO BUFFER',
	SUM(
		bh.buh_inventario_fisico * bh.buh_ctv
	) AS 'COSTO FISICO',
	SUM(
		bh.buh_inventario_proyectado * bh.buh_ctv
	) AS 'COSTO PROYECTADO',
	bh.buh_fecha AS 'FECHA'
FROM
	buffer_hist bh
INNER JOIN empresa e ON bh.buh_empresa = e.emp_codigo
WHERE
	bh.buh_fecha >= DATE_SUB(CURDATE(), INTERVAL 2 MONTH)
GROUP BY
	e.emp_nombre,
	bh.buh_clasificacion,
	bh.buh_responsable,
	bh.buh_fecha
ORDER BY
	bh.buh_empresa,
	bh.buh_fecha DESC ;

-- ----------------------------
-- View structure for v_cambios_sugeridos_gdb
-- ----------------------------
DROP VIEW IF EXISTS `v_cambios_sugeridos_gdb`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER  VIEW `v_cambios_sugeridos_gdb` AS SELECT
empresa.emp_nombre AS EMPRESA,
b.bod_nombre AS BODEGA,
dc.con_codigo AS CODIGO,
ip.pro_descripcion AS DESCRIPCION,
ip.pro_grupo AS GRUPO,
ip.pro_linea AS LINEA,
ip.pro_sublinea AS SUBLINEA,
ip.pro_modelo AS MODELO,
ip.pro_familia AS FAMILIA,
ip.pro_subfamilia AS SUBFAMILIA,
ip.pro_categoria AS CATEGORIA,
ip.pro_tipo AS TIPO,
ip.pro_marca AS MARCA,
ip.pro_cat_management AS `CAT MANAGEMENT`,
dc.con_buffer AS BUFFER,
dc.con_nuevo_buffer_sugerido AS SUGERIDO
FROM
datos_consolidados AS dc
INNER JOIN bodega AS b ON b.bodega_id = dc.con_bodega
left JOIN imp_producto AS ip ON ip.pro_codigo = dc.con_codigo
INNER JOIN empresa ON b.bod_empresa_id = empresa.empresa_id
WHERE
dc.con_nuevo_buffer_sugerido is not NULL
ORDER BY
BODEGA ASC,
CODIGO ASC ;

-- ----------------------------
-- View structure for v_cargar_entradas_salidas
-- ----------------------------
DROP VIEW IF EXISTS `v_cargar_entradas_salidas`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost`  VIEW `v_cargar_entradas_salidas` AS SELECT
	empresa.emp_nombre AS EMPRESA,
	imp_inventario.inv_producto_id AS CODIGO,
	bodega.bod_nombre AS BODEGA,
	imp_inventario.inv_fecha_actualizacion AS FECHA,
	imp_inventario.inv_entradas AS ENTRADAS,
	imp_inventario.inv_salidas AS SALIDAS
FROM
	imp_inventario
INNER JOIN bodega ON bodega.bod_codigo = imp_inventario.inv_bodega_id
INNER JOIN empresa ON bodega.bod_empresa_id = empresa.empresa_id
WHERE
	(
		imp_inventario.inv_entradas <> 0
		OR imp_inventario.inv_salidas <> 0
	) ;

-- ----------------------------
-- View structure for v_datos_consolidados
-- ----------------------------
DROP VIEW IF EXISTS `v_datos_consolidados`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER  VIEW `v_datos_consolidados` AS SELECT
empresa.emp_nombre AS EMPRESA,
b.bod_nombre AS BODEGA,
dc.con_codigo AS CODIGO,
ip.pro_descripcion AS DESCRIPCION,
ip.pro_grupo AS GRUPO,
ip.pro_linea AS LINEA,
ip.pro_sublinea AS SUBLINEA,
ip.pro_modelo AS MODELO,
ip.pro_familia AS FAMILIA,
ip.pro_subfamilia AS SUBFAMILIA,
ip.pro_categoria AS CATEGORIA,
ip.pro_tipo AS TIPO,
ip.pro_marca AS MARCA,
ip.pro_cat_management AS `CAT MANAGEMENT`,
dc.con_nuevo_buffer_sugerido AS SUGERIDO,
dc.con_codigo_generico AS 'COD GENERICO',
dc.con_codigo_vinculado AS 'COD VINCULADO',
dc.con_ctv AS 'CTV',
dc.con_pv AS 'PV',
dc.con_pedido_minimo AS 'PEDIDO MINIMO',
dc.con_pedido_minimo_grupo AS 'PEDIDO MIN GRUPO',
dc.con_unidad_empaque AS 'UNIDAD EMPAQUE',
dc.con_porcentaje_atencion AS 'PORCENTAJE ATENCION',
dc.con_inventario_proveedor AS 'INVENTARIO PROVEEDOR',
dc.con_buffer,
dc.con_inventario_fisico,
dc.con_color,
dc.con_estado_buffer,
dc.con_transito,
dc.con_negociacion,
dc.con_produccion,
dc.con_embarcado,
dc.con_comprometido,
dc.con_backorder,
dc.con_inventario_proyectado,
dc.con_pedido_calculado,
dc.con_pedido_promedio,
dc.con_tdd,
dc.con_idd,
dc.con_rentabilidad,
dc.con_velocity,
dc.con_nivel_servicio,
dc.con_ultimo_cambio,
dc.con_tipo_compra,
dc.con_consumo,
dc.con_ped_prom,
dc.con_gdb,
dc.con_cam,
dc.con_comportamiento,
dc.con_consumo1,
dc.con_buffer_calculado,
dc.con_cobertura_buffer,
dc.con_cobertura_inventario_proyectado,
dc.con_cobertura_pedido_minimo,
dc.con_dias_desabastecimiento,
dc.con_buffer_minimo,
dc.con_buffer_maximo,
dc.con_impacto_faltante,
dc.con_color1,
dc.con_ultimo_buffer,
dc.con_buffer_anterior_estacion,
dc.con_buffer_estacional,
dc.con_estado_buffer_proyectado,
dc.con_calendario_estacional,
dc.con_accion_estacional,
dc.con_etapa_estacional,
dc.con_rentabilidad_proyectada,
dc.con_inicio_horizonte,
dc.con_fin_horizonte,
dc.con_variabilidad,
dc.con_rojo_acumulado,
dc.con_negro,
dc.con_rojo,
dc.con_amarillo,
dc.con_verde,
dc.con_lila,
dc.con_ingresos,
dc.con_egresos
FROM
datos_consolidados AS dc
INNER JOIN bodega AS b ON b.bodega_id = dc.con_bodega
INNER JOIN imp_producto AS ip ON ip.pro_codigo = dc.con_codigo
INNER JOIN empresa ON b.bod_empresa_id = empresa.empresa_id
ORDER BY
BODEGA ASC,
CODIGO ASC ;

-- ----------------------------
-- View structure for v_dc_uno
-- ----------------------------
DROP VIEW IF EXISTS `v_dc_uno`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER  VIEW `v_dc_uno` AS SELECT
	e.emp_nombre AS 'EMPRESA',
	b.bod_nombre AS 'BODEGA',
	dc.con_codigo AS 'CODIGO',
	a.ach_nombre AS 'ARCHIVO'
FROM
	datos_consolidados dc
INNER JOIN empresa e ON dc.con_empresa = e.empresa_id
INNER JOIN bodega b ON dc.con_bodega = b.bodega_id
INNER JOIN archivo a ON dc.con_archivo = a.archivo_id 
ORDER BY e.emp_nombre, b.bod_nombre, dc.con_codigo, a.ach_nombre ;

-- ----------------------------
-- View structure for v_evolucion_colores
-- ----------------------------
DROP VIEW IF EXISTS `v_evolucion_colores`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER  VIEW `v_evolucion_colores` AS SELECT DISTINCT
	e.emp_nombre AS 'EMPRESA',
	b.bod_nombre AS 'BODEGA',
	bh.buh_clasificacion AS 'CLASIFICACION',
	bh.buh_responsable AS 'RESPONSABLE',
	bh.buh_fecha AS 'FECHA',
	SUM(

		IF (
			bh.buh_color_inventario_fisico = 'N',
			1,
			0
		)
	) AS 'NEGRO',
	sum(

		IF (
			bh.buh_color_inventario_fisico = 'R',
			1,
			0
		)
	) AS 'ROJO',
	sum(

		IF (
			bh.buh_color_inventario_fisico = 'A',
			1,
			0
		)
	) AS 'AMARILLO',
	sum(

		IF (
			bh.buh_color_inventario_fisico = 'V',
			1,
			0
		)
	) AS 'VERDE',
	sum(

		IF (
			bh.buh_color_inventario_fisico = 'L',
			1,
			0
		)
	) AS 'LILA',
	sum(

		IF (
			bh.buh_color_inventario_fisico = 'G',
			1,
			0
		)
	) AS 'GRIS'
FROM
	buffer_hist bh
INNER JOIN empresa e ON e.emp_codigo = bh.buh_empresa
INNER JOIN bodega b ON b.bod_codigo = bh.buh_bodega
WHERE
	bh.buh_fecha >= DATE_SUB(CURDATE(), INTERVAL 1 MONTH)
GROUP BY
	e.emp_nombre,
	b.bod_nombre,
	bh.buh_clasificacion,
	bh.buh_responsable,
	bh.buh_fecha
ORDER BY
	e.emp_nombre,
	b.bod_nombre,
	bh.buh_fecha DESC ;

-- ----------------------------
-- View structure for v_evolucion_sobreinventario
-- ----------------------------
DROP VIEW IF EXISTS `v_evolucion_sobreinventario`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER  VIEW `v_evolucion_sobreinventario` AS SELECT
	e.emp_nombre AS 'EMPRESA',
	bh.buh_clasificacion AS 'CLASIFICACION',
	bh.buh_responsable AS 'RESPONSABLE',
	SUM((bh.buh_inventario_fisico -	bh.buh_buffer_actual) * bh.buh_ctv)
	 AS 'SOBREINVENTARIO',
	bh.buh_fecha AS 'FECHA'
FROM
	buffer_hist bh
INNER JOIN empresa e ON bh.buh_empresa = e.emp_codigo
WHERE
	bh.buh_fecha >= DATE_SUB(CURDATE(), INTERVAL 2 MONTH) AND (bh.buh_inventario_fisico> bh.buh_buffer_actual)
GROUP BY
	e.emp_nombre,
	bh.buh_clasificacion,
	bh.buh_responsable,
	bh.buh_fecha
ORDER BY
	bh.buh_empresa,
	bh.buh_fecha DESC ;

-- ----------------------------
-- View structure for v_exp_ramcas_buffer_hoy
-- ----------------------------
DROP VIEW IF EXISTS `v_exp_ramcas_buffer_hoy`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER  VIEW `v_exp_ramcas_buffer_hoy` AS SELECT
	bh.buh_fecha AS 'FECHA',
	e.emp_nombre AS 'EMPRESA',
	b.bod_nombre AS 'BODEGA',
	a.ach_nombre AS 'HOJA CB',
	p.pro_nombre AS 'PROVEEDOR',
	pr.pre_nombre AS 'PERFIL',
	bh.buh_codigo AS 'CODIGO',
	bh.buh_codigo_vinculado AS 'CODIGO VINCULADO',
	bh.buh_codigo_generico AS 'CODIGO GENERICO',
	ip.pro_descripcion AS 'DESCRIPCION',
	ip.pro_grupo AS 'GRUPO',
	ip.pro_linea AS 'LINEA',
	ip.pro_sublinea AS 'SUBLINEA',
	ip.pro_modelo AS 'MODELO',
	ip.pro_familia AS 'FAMILIA',
	ip.pro_subfamilia AS 'SUBFAMILIA',
	ip.pro_categoria AS 'CATEGORIA',
	ip.pro_tipo AS 'TIPO',
	ip.pro_marca AS 'MARCA',
	bh.buh_responsable AS 'RESPONSABLE',
	bh.buh_ctv AS 'COSTO',
	bh.buh_pv AS 'PRECIO',
	bh.buh_horizonte AS 'HORIZONTE',
	bh.buh_tiempo_suministro AS 'T SUMINISTRO',
	bh.buh_frecuencia_reposicion AS 'FREC REPOS',
	bh.buh_etapa AS 'ETAPA',
	bh.buh_nuevo_buffer_sugerido AS 'BUFFER SUGERIDO',
	bh.buh_comportamiento AS 'COMPORTAMIENTO',
	bh.buh_consumo AS 'CONSUMO PROMEDIO',
	bh.buh_buffer_calculado AS 'BUFFER CALCULADO',
	bh.buh_buffer_actual AS 'BUFFER ACTUAL',
	bh.buh_color_inventario_fisico AS 'COLOR INV FIS',
	bh.buh_color_inventario_proyectado AS 'COLOR INV PROY',
	bh.buh_inventario_fisico AS 'INVENTARIO FISICO',
	bh.buh_transito AS 'TRANSITO',
	bh.buh_negociacion AS 'NEGOCIACION',
	bh.buh_produccion AS 'PRODUCCION',
	bh.buh_embarcado AS 'EMBARCADO',
	bh.buh_comprometido AS 'COMPROMETIDO',
	bh.buh_backorder AS 'BACKORDER',
	bh.buh_inventario_proyectado AS 'INV PROYECTADO',
	bh.buh_pedido_calculado AS 'REPOSICION',
	bh.buh_roi_pasado AS 'ROI_PASADO',
	bh.buh_roi_proyectado AS 'ROI_PROYECTADO',
	bh.buh_nivel_servicio AS 'SERVICIO',
	bh.buh_ultimo_cambio AS 'ULTIMO CAMBIO',
	bh.buh_estado_reposiciones AS 'ESTADO REPOSICION'
FROM
	buffer_hoy AS bh
LEFT JOIN empresa e ON e.emp_codigo = bh.buh_empresa
LEFT JOIN bodega b ON b.bod_empresa_id = e.empresa_id
AND bh.buh_bodega = b.bod_codigo
LEFT JOIN archivo a ON a.ach_empresa_id = e.empresa_id
AND bh.buh_archivo = a.archivo_id
LEFT JOIN imp_producto ip ON bh.buh_empresa = ip.pro_empresa_id
AND bh.buh_codigo = ip.pro_codigo
LEFT JOIN proveedor p ON p.proveedor_id = bh.buh_proveedor
LEFT JOIN perfilreposicion pr ON bh.buh_perfil = pr.perfilreposicion_id
ORDER BY
	e.emp_nombre,
	b.bod_nombre,
	bh.buh_codigo ;

-- ----------------------------
-- View structure for v_faltantes_actuales
-- ----------------------------
DROP VIEW IF EXISTS `v_faltantes_actuales`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER  VIEW `v_faltantes_actuales` AS SELECT DISTINCT
	e.emp_nombre AS EMPRESA,
	b.bod_nombre AS BODEGA,
	bh.buh_codigo AS CODIGO,
	ip.pro_descripcion AS DESCRIPCION,
	ip.pro_grupo AS GRUPO,
	ip.pro_linea AS LINEA,
	ip.pro_marca AS MARCA,
	ip.pro_modelo AS MODELO,
	bh.buh_buffer_actual AS BUFFER,
	bh.buh_transito AS TRANSITO,
	bh.buh_negociacion AS NEGOCIACION,
	bh.buh_produccion AS PRODUCCION,
	bh.buh_embarcado AS EMBARCADO,
	bh.buh_backorder AS BACKORDER,
	bh.buh_inventario_proyectado AS PROYECTADO,
	bh.buh_estatus AS ESTATUS
FROM
	buffer_hoy bh
INNER JOIN empresa e ON bh.buh_empresa = e.emp_codigo
INNER JOIN bodega b ON bh.buh_bodega = b.bod_codigo
INNER JOIN imp_producto ip ON ip.pro_codigo = bh.buh_codigo
WHERE
	bh.buh_inventario_fisico = 0
AND bh.buh_buffer_actual > 0 ;

-- ----------------------------
-- View structure for v_historial_causas
-- ----------------------------
DROP VIEW IF EXISTS `v_historial_causas`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER  VIEW `v_historial_causas` AS SELECT
	hc.hc_bodega_codigo AS 'BODEGA',
	hc.hc_codigo AS 'CODIGO',
	max(date(hc.hc_fecha)) AS 'FECHA',
	hc.hc_causa AS 'CAUSA'
FROM
	historial_causas hc
GROUP BY
hc.hc_bodega_codigo, hc.hc_codigo
ORDER BY
hc.hc_bodega_codigo, hc.hc_codigo, hc.hc_fecha ;

-- ----------------------------
-- View structure for v_inversion_buffers
-- ----------------------------
DROP VIEW IF EXISTS `v_inversion_buffers`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost`  VIEW `v_inversion_buffers` AS SELECT
	`histinventarios`.`EMPRESA` AS `EMPRESA`,
	`histinventarios`.`CODIGO` AS `CODIGO`,
	sum(
		(
			`histinventarios`.`BuffAct` * `histinventarios`.`CTV`
		)
	) AS `COSTO TOTAL`
FROM
	`histinventarios`
WHERE
	(
		(
			`histinventarios`.`BODEGA` not like '%PROPIA'
		)

		AND (
			`histinventarios`.`FECHA` = (
				SELECT
					max(`histinventarios`.`FECHA`) AS `max(HISTINVENTARIOS.FECHA)`
				FROM
					`histinventarios`
			)
		)
	)
GROUP BY
	`histinventarios`.`EMPRESA`,
	`histinventarios`.`CODIGO`
ORDER BY
	`histinventarios`.`EMPRESA`,
	`histinventarios`.`CODIGO` ;

-- ----------------------------
-- View structure for v_items_repetidos_bodegas
-- ----------------------------
DROP VIEW IF EXISTS `v_items_repetidos_bodegas`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER  VIEW `v_items_repetidos_bodegas` AS SELECT
		e.emp_nombre AS 'EMPRESA',
		b.bod_nombre AS 'BODEGA',
		dc.con_codigo AS 'CODIGO'
	FROM
		datos_consolidados dc
	INNER JOIN empresa e ON dc.con_empresa = e.empresa_id
	INNER JOIN bodega b ON dc.con_bodega = b.bodega_id
	GROUP BY
		dc.con_empresa,
		dc.con_bodega,
		dc.con_codigo
	HAVING
		COUNT(dc.con_codigo) > 1
	ORDER BY e.emp_nombre, b.bod_nombre, dc.con_codigo ;

-- ----------------------------
-- View structure for v_num_buffers_invfisico
-- ----------------------------
DROP VIEW IF EXISTS `v_num_buffers_invfisico`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER  VIEW `v_num_buffers_invfisico` AS SELECT
	emp.emp_nombre AS 'EMPRESA',
	bod.bod_nombre AS 'BODEGA',
	a.Negro AS 'NEGRO',
	b.Rojo AS 'ROJO',
	c.Lila AS 'LILA',
	d.Amarillo AS 'AMARILLO',
	e.Verde AS 'VERDE',
	f.Gris AS 'GRIS'
FROM
	v_bodega_negro a
INNER JOIN v_bodega_rojo b ON a.con_bodega = b.con_bodega
INNER JOIN v_bodega_lila c ON a.con_bodega = c.con_bodega
INNER JOIN v_bodega_amarillo d ON a.con_bodega = d.con_bodega
INNER JOIN v_bodega_verde e ON a.con_bodega = e.con_bodega
INNER JOIN v_bodega_gris f ON a.con_bodega = f.con_bodega
INNER JOIN bodega bod ON bod.bodega_id = a.con_bodega
INNER JOIN empresa emp ON bod.bod_empresa_id = emp.empresa_id
ORDER BY
	EMPRESA,
	BODEGA ;

-- ----------------------------
-- View structure for v_num_buffers_invfisico_total
-- ----------------------------
DROP VIEW IF EXISTS `v_num_buffers_invfisico_total`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER  VIEW `v_num_buffers_invfisico_total` AS SELECT
	v_num_buffers_invfisico.EMPRESA AS EMPRESA,
	Sum(
		v_num_buffers_invfisico.NEGRO
	) AS NEGRO,
	Sum(
		v_num_buffers_invfisico.ROJO
	) AS ROJO,
	Sum(
		v_num_buffers_invfisico.LILA
	) AS LILA,
	Sum(
		v_num_buffers_invfisico.AMARILLO
	) AS AMARILLO,
	Sum(
		v_num_buffers_invfisico.VERDE
	) AS VERDE,
	Sum(
		v_num_buffers_invfisico.GRIS
	) AS GRIS,
	(
		Sum(
			v_num_buffers_invfisico.NEGRO
		) + Sum(
			v_num_buffers_invfisico.ROJO
		) + Sum(
			v_num_buffers_invfisico.LILA
		) + Sum(
			v_num_buffers_invfisico.AMARILLO
		) + Sum(
			v_num_buffers_invfisico.VERDE
		) + Sum(
			v_num_buffers_invfisico.GRIS
		)
	) AS TOTAL
FROM
	v_num_buffers_invfisico
GROUP BY
	v_num_buffers_invfisico.EMPRESA ;

-- ----------------------------
-- View structure for v_pareto_causas
-- ----------------------------
DROP VIEW IF EXISTS `v_pareto_causas`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER  VIEW `v_pareto_causas` AS SELECT
e.emp_nombre AS 'EMPRESA',
b.bod_nombre AS 'BODEGA',
date(concat(year(hc.hc_fecha),'-',month(hc.hc_fecha),'-1')) AS 'MES',
hc.hc_tipo AS 'TIPO',
hc.hc_causa AS 'CAUSA',
count(hc.hc_causa) AS 'CANTIDAD'
FROM
historial_causas hc
INNER JOIN bodega b ON hc.hc_bodega_codigo = b.bod_codigo
INNER JOIN empresa e ON b.bod_empresa_id = e.empresa_id AND hc.hc_empresa_codigo = e.emp_codigo 
WHERE DATE(hc.hc_fecha) >= DATE_SUB(CURDATE(),INTERVAL 3 MONTH)
GROUP BY e.emp_nombre, b.bod_nombre, EXTRACT(YEAR_MONTH FROM hc.hc_fecha), hc.hc_tipo, hc.hc_causa 
ORDER BY `MES` DESC, `CANTIDAD` DESC ;

-- ----------------------------
-- View structure for v_productos_dados_de_baja
-- ----------------------------
DROP VIEW IF EXISTS `v_productos_dados_de_baja`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER  VIEW `v_productos_dados_de_baja` AS SELECT DISTINCT
	c.con_codigo
FROM
	datos_consolidados c
LEFT JOIN imp_producto i ON c.con_codigo = i.pro_codigo
WHERE
	i.pro_codigo IS NULL
ORDER BY
	c.con_codigo ;

-- ----------------------------
-- View structure for v_reporte_causas
-- ----------------------------
DROP VIEW IF EXISTS `v_reporte_causas`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost`  VIEW `v_reporte_causas` AS SELECT
	historialcausas.Empresa AS 'EMPRESA',
	historialcausas.BODEGA AS 'BODEGA',
	historialcausas.Causa AS 'CAUSA',
	count(historialcausas.causa) 'CANTIDAD'
FROM
	historialcausas
WHERE
	fecha >= DATE_SUB(now(), INTERVAL 30 DAY)
GROUP BY
	historialcausas.Causa
ORDER BY
	`CANTIDAD` DESC ;

-- ----------------------------
-- View structure for v_roi
-- ----------------------------
DROP VIEW IF EXISTS `v_roi`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER  VIEW `v_roi` AS SELECT
	trim(v_truput_total.pro_codigo) AS 'CODIGO',
	#v_truput_total.pro_truput_total AS 'TRUPUT ANUAL',
	#v_inversion_buffers.`COSTO TOTAL` AS 'COSTO TOTAL',
IF (
	(
		v_truput_total.pro_truput_total / v_inversion_buffers.`COSTO TOTAL`
	) IS NULL,
	0,
	(
		v_truput_total.pro_truput_total / v_inversion_buffers.`COSTO TOTAL`
	) 
) AS 'ROI'
FROM
	v_truput_total
INNER JOIN v_inversion_buffers ON v_truput_total.pro_codigo = v_inversion_buffers.CODIGO
ORDER BY
	'CODIGO' ;

-- ----------------------------
-- View structure for v_sobreinventario_fisico_valorado
-- ----------------------------
DROP VIEW IF EXISTS `v_sobreinventario_fisico_valorado`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER  VIEW `v_sobreinventario_fisico_valorado` AS SELECT
emp_nombre AS 'EMPRESA',
bod_nombre AS 'BODEGA',
buh_codigo AS 'CODIGO',
buh_codigo_vinculado AS 'CODIGO VINCULADO',
pro_descripcion AS 'DESCRIPCION',
pro_grupo AS 'GRUPO',
pro_linea AS 'LINEA',
pro_sublinea AS 'SUBLINEA',
pro_modelo AS 'MODELO',
pro_familia AS 'FAMILIA',
pro_subfamilia AS 'SUBFAMILIA',
pro_categoria AS 'CATEGORIA',
pro_tipo as 'TIPO',
pro_marca AS 'MARCA',
buh_buffer_actual AS 'BUFFER',
buh_inventario_fisico AS 'FISICO',
(buh_inventario_fisico - buh_buffer_actual) AS 'CANTIDAD',
buh_ctv AS 'CTV',
ROUND(((buh_inventario_fisico- buh_buffer_actual)*buh_ctv),2) AS 'VALOR'
FROM v_buffer_hist_hoy
WHERE buh_inventario_fisico > buh_buffer_actual
ORDER BY
ROUND(((buh_inventario_fisico- buh_buffer_actual)*buh_ctv),2) DESC ;

-- ----------------------------
-- View structure for v_sobreinventario_proyectado_valorado
-- ----------------------------
DROP VIEW IF EXISTS `v_sobreinventario_proyectado_valorado`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER  VIEW `v_sobreinventario_proyectado_valorado` AS SELECT
emp_nombre AS 'EMPRESA',
bod_nombre AS 'BODEGA',
buh_codigo AS 'CODIGO',
buh_codigo_vinculado AS 'CODIGO VINCULADO',
pro_descripcion AS 'DESCRIPCION',
pro_grupo AS 'GRUPO',
pro_linea AS 'LINEA',
pro_sublinea AS 'SUBLINEA',
pro_modelo AS 'MODELO',
pro_familia AS 'FAMILIA',
pro_subfamilia AS 'SUBFAMILIA',
pro_categoria AS 'CATEGORIA',
pro_tipo as 'TIPO',
pro_marca AS 'MARCA',
buh_buffer_actual AS 'BUFFER',
buh_inventario_fisico AS 'FISICO',
buh_transito AS 'TRANSITO',
buh_inventario_proyectado AS 'PROYECTADO',
(buh_inventario_proyectado - buh_buffer_actual) AS 'CANTIDAD',
buh_ctv AS 'CTV',
ROUND(((buh_inventario_proyectado- buh_buffer_actual)*buh_ctv),2) AS 'VALOR'
FROM v_buffer_hist_hoy
WHERE buh_inventario_proyectado > buh_buffer_actual
ORDER BY
ROUND(((buh_inventario_proyectado- buh_buffer_actual)*buh_ctv),2) DESC ;

-- ----------------------------
-- View structure for v_sobreinventario_valorado
-- ----------------------------
DROP VIEW IF EXISTS `v_sobreinventario_valorado`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER  VIEW `v_sobreinventario_valorado` AS SELECT
	histinventarios.EMPRESA AS 'EMPRESA',
	histinventarios.BODEGA AS 'BODEGA',
	histinventarios.CODIGO AS 'CODIGO',
	imp_producto.pro_descripcion AS 'DESCRIPCION',
	imp_producto.pro_linea AS 'LINEA',
	histinventarios.BuffAct AS 'BUFFER',
	histinventarios.InvFisAct AS 'INVENTARIO FISICO',
	histinventarios.TransAct AS 'TRANSITO',
	histinventarios.InvProyAct AS 'INVENTARIO PROYECTADO',
	(
		histinventarios.InvProyAct - histinventarios.BuffAct
	) AS 'CANTIDAD',
	histinventarios.CTV,
	(
		(
			histinventarios.InvProyAct - histinventarios.BuffAct
		) * histinventarios.CTV
	) AS 'SOBREINVENTARIO'
FROM
	histinventarios
INNER JOIN imp_producto ON imp_producto.pro_codigo = histinventarios.CODIGO
WHERE
	(
		(
			(
				histinventarios.InvProyAct - histinventarios.BuffAct
			) > 0
		)
		AND (
			`histinventarios`.`FECHA` = (
				SELECT
					max(`histinventarios`.`FECHA`) AS `max(HISTINVENTARIOS.FECHA)`
				FROM
					`histinventarios`
			)
		)
	)
ORDER BY
	EMPRESA,
	BODEGA,
	SOBREINVENTARIO DESC ;

-- ----------------------------
-- View structure for v_truput_total
-- ----------------------------
DROP VIEW IF EXISTS `v_truput_total`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER  VIEW `v_truput_total` AS SELECT
	imp_producto.pro_codigo,
	imp_producto.pro_truput_total
FROM
	imp_producto
ORDER BY
	pro_codigo ;

-- ----------------------------
-- View structure for v_usuario_clave
-- ----------------------------
DROP VIEW IF EXISTS `v_usuario_clave`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER  VIEW `v_usuario_clave` AS SELECT
	u.usu_nombre AS 'USUARIO',
	(
		DES_DECRYPT(
			UNHEX(u.usu_clave),
			'29f0f55dc6b44fbf80e65c4ef5a7d364'
		)
	) AS 'CLAVE',
	u.usu_clave AS 'ENCRIPTADA'
FROM
	usuario u ;

-- ----------------------------
-- Procedure structure for Crea_Buffer_Hist_Cortado
-- ----------------------------
DROP PROCEDURE IF EXISTS `Crea_Buffer_Hist_Cortado`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `Crea_Buffer_Hist_Cortado`()
BEGIN

START TRANSACTION;

		-- Borra la tabla buffer_hist_cortado	
		DROP TABLE IF EXISTS buffer_hist_cortado;
		-- Crea una copia de la tabla buffer_hist llamándola buffer_hist_cortado
		CREATE TABLE buffer_hist_cortado like buffer_hist;		
		-- Llena los datos de buffer_hist_cortado con un query de buffer_hist para que tenga menos datos
		INSERT INTO buffer_hist_cortado
		SELECT * FROM buffer_hist bh WHERE bh.buh_fecha >= DATE_SUB(CURDATE(),INTERVAL 3 MONTH); 
	
COMMIT;

END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for Llena_Numeracion_Transferencias
-- ----------------------------
DROP PROCEDURE IF EXISTS `Llena_Numeracion_Transferencias`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `Llena_Numeracion_Transferencias`(IN `repeticiones` mediumint)
BEGIN
	
	DECLARE intento MEDIUMINT UNSIGNED DEFAULT 0;
	DECLARE contador MEDIUMINT UNSIGNED DEFAULT 0;
	
	llena: LOOP
			SET contador = contador +1;
			IF contador > repeticiones THEN
				LEAVE llena;
			ELSE
				INSERT INTO seq_transferencia (seq_transferencia.seqt_nombre)
				VALUES (1); 
			END IF;

	END LOOP llena;

END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for Nueva_Transferencia
-- ----------------------------
DROP PROCEDURE IF EXISTS `Nueva_Transferencia`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `Nueva_Transferencia`()
BEGIN
	
	DECLARE numero_nuevo MEDIUMINT UNSIGNED;
	
	START TRANSACTION;
	
			INSERT INTO seq_transferencia (seq_transferencia.seqt_nombre)
			VALUES (1);
			SELECT LAST_INSERT_ID();
	
	COMMIT;	
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for p_usuario_clave
-- ----------------------------
DROP PROCEDURE IF EXISTS `p_usuario_clave`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `p_usuario_clave`()
BEGIN
	
	START TRANSACTION;

		-- Borra la tabla temporal que se creó anteriormente	
		DROP TABLE IF EXISTS tmp_v_usuario_clave;
		-- Crea una nueva tabla a partir de la vista v_usuario_clave
		CREATE TABLE tmp_v_usuario_clave SELECT * FROM v_usuario_clave;
		-- Cambia el campo varbinary por un varchar sencillo para que pueda ser importado por ADODB
		ALTER TABLE tmp_v_usuario_clave MODIFY COLUMN `CLAVE`  varchar(41) BINARY NULL DEFAULT NULL AFTER `USUARIO`;

	COMMIT;

END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for Sincroniza_Datos_Bodega
-- ----------------------------
DROP PROCEDURE IF EXISTS `Sincroniza_Datos_Bodega`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `Sincroniza_Datos_Bodega`()
BEGIN
	
	DECLARE deadlock INT DEFAULT 0; 
	DECLARE	attempts INT DEFAULT 0;
	DECLARE out_status INT DEFAULT 0;
	DECLARE out_message VARCHAR(20);

	sinc_empresa_loop: WHILE (attempts <3) DO
			BEGIN
					DECLARE codigo_bodega varchar(15);
					DECLARE codigo_empresa varchar(15);
					DECLARE nombre_bodega varchar(30);
					DECLARE nombre_empresa varchar(30);
					DECLARE done int DEFAULT 0;
					DECLARE deadlock_detected CONDITION FOR 1213;
					DECLARE EXIT HANDLER FOR deadlock_detected

					BEGIN
						ROLLBACK;
						SET deadlock = 1;
					END;
					SET deadlock = 0;
					
					START TRANSACTION;
							
							-- Verifica los ítems que hay que añadir de imp_bodega a bodega, los que son activos
							BEGIN
									INSERT INTO bodega (
										bod_empresa_id,
										bod_codigo,
										bod_nombre,
										bod_activa,
										bod_es_planta,
										bod_maneja_inventario,
										bod_tiene_reposicion,
										bod_maneja_exhibicion,
										bod_tiene_facturacion,
										bod_es_consignacion,
										bod_es_proveedor,
										bod_tipo_reposicion,
										bod_es_propia,
										bod_transito_propio,
										bod_transito_externo
									)(
										SELECT
										emp.empresa_id,
										-- a.bod_empresa_id,
										a.bod_codigo,
										a.bod_nombre,
										a.bod_activa,
										a.bod_es_planta,
										a.bod_maneja_inventario,
										a.bod_tiene_reposicion,
										a.bod_maneja_exhibicion,
										a.bod_tiene_facturacion,
										a.bod_es_consignacion,
										a.bod_es_proveedor,
										a.bod_tipo_reposicion,
										a.bod_es_propia,
										a.bod_transito_propio,
										a.bod_transito_externo
									FROM
									(SELECT
										ib.bod_empresa_id,
										ib.bod_codigo,
										ib.bod_nombre,
										ib.bod_activa,
										ib.bod_es_planta,
										ib.bod_maneja_inventario,
										ib.bod_tiene_reposicion,
										ib.bod_maneja_exhibicion,
										ib.bod_tiene_facturacion,
										ib.bod_es_consignacion,
										ib.bod_es_proveedor,
										ib.bod_tipo_reposicion,
										ib.bod_es_propia,
										ib.bod_transito_propio,
										ib.bod_transito_externo
									FROM
										bodega AS b
									INNER JOIN empresa AS e ON b.bod_empresa_id = e.empresa_id
									RIGHT JOIN imp_bodega ib ON b.bod_codigo = ib.bod_codigo
									AND e.emp_codigo = ib.bod_empresa_id
									WHERE
										b.bod_codigo IS NULL) a INNER JOIN empresa emp ON emp.emp_codigo=a.bod_empresa_id
									);
							END;
							
							-- Verifica los ítems que hay que desactivar en empresa, porque ya no constan en imp_empresa
							BEGIN
									DECLARE cur1 CURSOR FOR
									SELECT
										e.empresa_id, b.bod_codigo, b.bod_nombre
									FROM
									bodega AS b
									LEFT JOIN imp_bodega AS ib ON b.bod_codigo = ib.bod_codigo
									INNER JOIN empresa e ON e.empresa_id = b.bod_empresa_id
									WHERE ib.bod_codigo IS null;
									
									DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

									OPEN cur1;
									desactivar_bodegas:LOOP
											FETCH cur1 INTO codigo_empresa, codigo_bodega, nombre_bodega;
											IF done = 1 THEN
													LEAVE desactivar_bodegas;
											END IF;
											-- Cambia el estatus de la bodega en la tabla bodega
											UPDATE bodega b SET b.bod_activa = 0
											WHERE b.bod_empresa_id = codigo_empresa AND b.bod_codigo = codigo_bodega;
									END LOOP desactivar_bodegas;
									CLOSE cur1;
							END;
					
							-- Actualiza los valores de las bodegas presentes que provienen de imp_empresa en empresa
							BEGIN
									UPDATE bodega AS b
									INNER JOIN empresa AS e ON b.bod_empresa_id = e.empresa_id
									INNER JOIN imp_bodega ib ON ib.bod_codigo = b.bod_codigo
									AND ib.bod_empresa_id = e.emp_codigo
									SET b.bod_nombre = ib.bod_nombre,
									 b.bod_es_planta = ib.bod_es_planta,
									 b.bod_maneja_inventario = ib.bod_maneja_inventario,
									 b.bod_tiene_reposicion = ib.bod_tiene_reposicion,
									 b.bod_maneja_exhibicion = ib.bod_maneja_exhibicion,
									 b.bod_tiene_facturacion = ib.bod_tiene_facturacion,
									 b.bod_es_consignacion = ib.bod_es_consignacion,
									 b.bod_es_proveedor = ib.bod_es_proveedor,
									 b.bod_tipo_reposicion = ib.bod_tipo_reposicion,
									 b.bod_es_propia = ib.bod_es_propia,
									 b.bod_transito_propio = ib.bod_transito_propio,
									 b.bod_transito_externo = ib.bod_transito_externo;
									 -- b.bod_activa = ib.bod_activa;	
							END;
					COMMIT;
			END; 
	
			IF deadlock = 0 THEN
				LEAVE sinc_empresa_loop;
			ELSE
				SET attempts = attempts + 1;
			END IF;
			
	END WHILE sinc_empresa_loop;
	
	IF deadlock = 1 THEN
		SET out_status = -1;
		SET out_message = "Fallo por estar bloqueado luego de tres intentos";
	ELSE
		SET out_status = 0;
		SET out_message = CONCAT("OK (",attempts," bloqueos)");
	END IF;

END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for Sincroniza_Datos_Empresa
-- ----------------------------
DROP PROCEDURE IF EXISTS `Sincroniza_Datos_Empresa`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `Sincroniza_Datos_Empresa`()
BEGIN
	
	DECLARE deadlock INT DEFAULT 0; 
	DECLARE	attempts INT DEFAULT 0;
	DECLARE out_status INT DEFAULT 0;
	DECLARE out_message VARCHAR(20);

	sinc_empresa_loop: WHILE (attempts <3) DO
			BEGIN
					DECLARE codigo_empresa varchar(15);
					DECLARE nombre_empresa varchar(30);
					DECLARE done int DEFAULT 0;
					DECLARE deadlock_detected CONDITION FOR 1213;
					DECLARE EXIT HANDLER FOR deadlock_detected

					BEGIN
						ROLLBACK;
						SET deadlock = 1;
					END;
					SET deadlock = 0;
					
					START TRANSACTION;
							
							-- Verifica los ítems que hay que añadir de imp_empresa a empresa, los que son activos
							BEGIN
									INSERT INTO empresa (emp_codigo, emp_nombre, emp_nombrecompleto, emp_notas, emp_activa) 
									(SELECT
										ie.emp_codigo, ie.emp_nombre, ie.emp_nombre_completo, ie.emp_notas, ie.emp_activa
									FROM
										empresa e
									RIGHT JOIN imp_empresa ie ON e.emp_codigo = ie.emp_codigo 
									WHERE e.emp_codigo IS null);
							END;
							
							-- Verifica los ítems que hay que desactivar en empresa, porque ya no constan en imp_empresa
							BEGIN
									DECLARE cur1 CURSOR FOR
											SELECT
												e.emp_codigo, e.emp_nombre
											FROM
												empresa e
											LEFT JOIN imp_empresa ie ON e.emp_codigo = ie.emp_codigo 
											WHERE ie.emp_codigo IS null;
									
									DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

									OPEN cur1;
									desactivar_empresas:LOOP
											FETCH cur1 INTO codigo_empresa, nombre_empresa;
											IF done = 1 THEN
													LEAVE desactivar_empresas;
											END IF;
											-- Cambia el estatus de la empresa en la tabla empresa
											UPDATE empresa e SET e.emp_activa = 0
											WHERE e.emp_codigo = codigo_empresa;
									END LOOP desactivar_empresas;
									CLOSE cur1;
							END;
					
							-- Actualiza los valores de las bodegas presentes que provienen de imp_empresa en empresa
							BEGIN
									UPDATE empresa e
									INNER JOIN imp_empresa ie ON e.emp_codigo = ie.emp_codigo
									SET e.emp_nombre = ie.emp_nombre,
									 e.emp_nombrecompleto = ie.emp_nombre_completo;	
							END;
					COMMIT;
			END; 
	
			IF deadlock = 0 THEN
				LEAVE sinc_empresa_loop;
			ELSE
				SET attempts = attempts + 1;
			END IF;
			
	END WHILE sinc_empresa_loop;
	
	IF deadlock = 1 THEN
		SET out_status = -1;
		SET out_message = "Fallo por estar bloqueado luego de tres intentos";
	ELSE
		SET out_status = 0;
		SET out_message = CONCAT("OK (",attempts," bloqueos)");
	END IF;

END
;;
DELIMITER ;

-- ----------------------------
-- Function structure for Nueva_Transferencia_Numeracion
-- ----------------------------
DROP FUNCTION IF EXISTS `Nueva_Transferencia_Numeracion`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `Nueva_Transferencia_Numeracion`(parametro CHAR(1)) RETURNS mediumint(9)
BEGIN
		DECLARE numero_nuevo MEDIUMINT UNSIGNED;
		
			INSERT INTO seq_transferencia (seq_transferencia.seqt_nombre)
			VALUES (1);
			SELECT LAST_INSERT_ID() INTO numero_nuevo;
			RETURN numero_nuevo;		
	
END
;;
DELIMITER ;

-- ----------------------------
-- Event structure for Crea_Buffer_Hist_Cortado
-- ----------------------------
DROP EVENT IF EXISTS `Crea_Buffer_Hist_Cortado`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` EVENT `Crea_Buffer_Hist_Cortado` ON SCHEDULE EVERY 1 DAY STARTS '2018-03-05 04:00:00' ON COMPLETION PRESERVE ENABLE DO CALL Crea_Buffer_Hist_Cortado()
;;
DELIMITER ;
