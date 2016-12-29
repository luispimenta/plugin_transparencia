<?php
/*
Plugin Name: Transparência
Description: Upload de arquivos para o menu transparência
Author: Luis Fernando Pimenta
Version: 0.1
*/
add_action('admin_menu', 'plugin_setup_menu');

function plugin_setup_menu(){
        add_menu_page( 'Trânsparencia', 'Trânsparencia', 'manage_options', 'transparencia-plugin', 'init' );
}

function init(){
        echo "<h1>Realize o upload do arquivo logo em baixo :</h1>";
        echo "<br>";
        echo "<form enctype='multipart/form-data' action='' method='POST'>";
        echo "<table>";
        echo "<tr>";
        echo "<td><label>Informe um título : </label></td><td><input type='text' name='title' value='' placeholder='Agosto de 2016' /></td>";
        echo "</tr>";
        echo "<tr>";
        echo "<td>Selecione o XSL : </td><td><input name='xsl' type='file' accept='.xsl' /><td>";
        echo "</tr>";
        echo "<tr>";
        echo "<td>Selecione o XML : </td><td><input name='xml' type='file' accept='.xml' /><td>";
        echo "</tr>";
        echo "<tr>";
        echo "<td>";
        echo "<input type='submit' value='Enviar' />";
        echo "</td>";
        echo "</tr>";
        echo "</table>";
        echo "</form>";
        insert_post();
}

function insert_post(){
  if (isset($_POST['title']) && $_POST['title'] != "") {
    $post_title = $_POST['title'];
    $post_category = '4';
    $link = '';
    $today = date("Y-m-d-H:i:s");
    $uploaddir = dirname( __FILE__ ) . '/uploads/';

    // upload dp xml
    $uploadfile = $uploaddir . $today . '-' . basename($_FILES['xml']['name']);
    echo '<pre>';
    if (move_uploaded_file($_FILES['xml']['tmp_name'], $uploadfile)) {
        echo "XML enviado com sucesso.\n";
        $link = "<a href=" . plugins_url() . "/transparencia/uploads/" . $today . "-" . basename($_FILES['xml']['name']) . " target='_blank'>" . $post_title . "</a>";
    } else {
        echo "Erro no upload dos arquivos !\n";
    }

    // upload dp xsl
    $uploadfile = $uploaddir . basename($_FILES['xsl']['name']);
    echo '<pre>';
    if (move_uploaded_file($_FILES['xsl']['tmp_name'], $uploadfile)) {
        echo "XSL enviado com sucesso.\n";
        // echo "<a href=" . plugins_url() . '/transparencia/uploads/' . basename($_FILES['xml']['name']) . ">link</a>";
    } else {
        echo "Erro no upload dos arquivos !\n";
    }

    //echo 'Aqui está mais informações de debug:';
    //print_r($_FILES);
    print "</pre>";

    $post_content = $link;

    $new_post = array(
          'ID' => '',
          'post_author' => 1,
          'post_category' => array($post_category),
          'post_content' => $post_content,
          'post_title' => $post_title,
          'post_status' => 'publish',
          'comment_status' => 'close'
        );

    $post_id = wp_insert_post($new_post);

    if($post_id > 0){
        echo 'Arquivo inserido com sucesso';
    }else{
        echo 'Houve algum problemas, tente novamente !';
    }
  }
}
?>
