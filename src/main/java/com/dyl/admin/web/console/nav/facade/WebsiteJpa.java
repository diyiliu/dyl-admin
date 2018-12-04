package com.dyl.admin.web.console.nav.facade;

import com.dyl.admin.web.console.nav.dto.Website;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;

import java.util.List;

/**
 * Description: WebsiteJpa
 * Author: DIYILIU
 * Update: 2018-05-15 21:18
 */
public interface WebsiteJpa extends JpaRepository<Website, Long>, JpaSpecificationExecutor<Website> {

    List<Website> findByIdIn(List<Long> ids);
}
